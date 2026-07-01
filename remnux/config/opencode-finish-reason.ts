// Surface non-normal LLM stop reasons and session errors on two
// surfaces: a long-duration TUI toast, and a log entry. Normal
// terminations ("stop", "tool-calls") are ignored so healthy turns
// produce no noise.
//
// Every abnormal event lands in ~/.local/share/opencode/log/*.log
// under service=finish-reason-plugin, so there's a trail even in
// headless mode where the toast is unavailable.
//
// Placed in ~/.config/opencode/plugins/ so it applies to every project.

import type { Plugin } from "@opencode-ai/plugin"

// Reasons we consider normal and therefore silent. Everything not in this
// set is surfaced. This is an allowlist rather than a denylist so that if
// OpenCode adds a new finish reason (e.g. "refusal") we notice it by
// default instead of dropping it silently.
const SILENT_FINISH_REASONS = new Set(["stop", "tool-calls"])

// Per-reason presentation. Reasons not listed here fall back to a generic
// warning toast so unknown values still surface.
type ToastVariant = "info" | "success" | "warning" | "error"
const REASON_META: Record<string, { variant: ToastVariant; label: string }> = {
  "content-filter": { variant: "error",   label: "Response blocked by the provider's content filter" },
  "length":         { variant: "warning", label: "Response cut off (max output tokens reached)" },
  "error":          { variant: "error",   label: "Provider returned an error mid-stream" },
  "unknown":        { variant: "warning", label: "Response ended for an unknown reason" },
  "other":          { variant: "warning", label: "Response ended with an 'other' finish reason" },
}

// Cap dedup memory. OpenCode message IDs are globally unique so
// (messageID, reason) collisions are effectively impossible; the cap only
// exists so a long-running `opencode serve` cannot leak memory over weeks.
const DEDUP_MAX = 1024

// Cap toast body length so a verbose provider error message can't
// break the TUI layout. The log entry always carries the full,
// untruncated error object in its `extra` field.
const TOAST_MAX = 240

// How long toasts stay on screen. The default is a few seconds which
// is easy to miss; 60 s is long enough to notice without being
// permanent.
const TOAST_DURATION_MS = 60_000

function truncate(s: string, max = TOAST_MAX): string {
  return s.length <= max ? s : s.slice(0, max - 1) + "\u2026"
}

// Short session ID suffix so multi-session users can tell which session
// produced the toast. Falls back gracefully if the ID is unexpectedly short.
function shortSession(id: string | undefined): string {
  if (!id) return "?"
  return id.length <= 6 ? id : id.slice(-6)
}

export const FinishReasonPlugin: Plugin = async ({ client }) => {
  // Bounded dedup. Using a Set + insertion order (JavaScript Sets preserve
  // insertion order) gives cheap FIFO eviction: on overflow we drop the
  // oldest entry.
  const seen = new Set<string>()
  const remember = (key: string): boolean => {
    if (seen.has(key)) return false
    seen.add(key)
    if (seen.size > DEDUP_MAX) {
      const oldest = seen.values().next().value
      if (oldest !== undefined) seen.delete(oldest)
    }
    return true
  }

  // Log first so the audit trail is durable even if the TUI call rejects
  // or is swallowed. Each side effect is isolated so one failure never
  // taints the other.
  async function logSafely(payload: {
    service: string
    level: "debug" | "info" | "warn" | "error"
    message: string
    extra?: Record<string, unknown>
  }): Promise<void> {
    try {
      await client.app.log({ body: payload })
    } catch {
      // Nothing sensible to do; the whole point of this plugin is
      // diagnostics, so we must not throw from within our own reporter.
    }
  }

  async function toastSafely(body: {
    variant: ToastVariant
    title: string
    message: string
  }): Promise<void> {
    try {
      await client.tui.showToast({ body: { ...body, duration: TOAST_DURATION_MS } })
    } catch {
      // showToast is only wired when the TUI is attached; ignore in
      // headless / server modes.
    }
  }

  function metaFor(reason: string): { variant: ToastVariant; label: string } {
    if (Object.hasOwn(REASON_META, reason)) return REASON_META[reason]
    return { variant: "warning", label: `Response ended with reason '${reason}'` }
  }

  return {
    event: async ({ event }) => {
      // Case 1: an assistant message completed with an abnormal finish reason.
      if (event.type === "message.updated") {
        const msg = event.properties.info
        if (msg.role !== "assistant") return
        const reason = msg.finish
        if (!reason || SILENT_FINISH_REASONS.has(reason)) return

        const key = `msg:${msg.id}:${reason}`
        if (!remember(key)) return

        const { variant, label } = metaFor(reason)

        // If the message carries a typed error payload (present when
        // finish === "error"), surface its message so the user doesn't
        // have to open the logs to see what actually failed.
        let detail = label
        const err = msg.error
        if (err && "data" in err) {
          const errMsg = (err.data as { message?: unknown })?.message
          if (typeof errMsg === "string" && errMsg.length > 0) {
            detail = `${label}: ${errMsg}`
          }
        }

        await logSafely({
          service: "finish-reason-plugin",
          level: variant === "error" ? "error" : "warn",
          message: `assistant message finished with reason=${reason}`,
          extra: {
            messageID: msg.id,
            sessionID: msg.sessionID,
            reason,
            error: err,
          },
        })

        await toastSafely({
          variant,
          title: `LLM stop: ${reason} (session ${shortSession(msg.sessionID)})`,
          message: truncate(detail),
        })
        return
      }

      // Case 2: a session-level error that never produced a completed
      // assistant message (auth failure, API 5xx, aborted stream, ...).
      if (event.type === "session.error") {
        const props = event.properties
        const err = props.error
        if (!err) return

        // Dedup by session + error name; without a message ID we key on
        // the pair, which is coarse but adequate.
        const key = `ses:${props.sessionID ?? "?"}:${err.name}`
        if (!remember(key)) return

        const errMsg =
          "data" in err && typeof (err.data as { message?: unknown })?.message === "string"
            ? ((err.data as { message: string }).message)
            : err.name

        await logSafely({
          service: "finish-reason-plugin",
          level: "error",
          message: `session error: ${err.name}`,
          extra: { sessionID: props.sessionID, error: err },
        })

        await toastSafely({
          variant: "error",
          title: `Session error: ${err.name} (session ${shortSession(props.sessionID)})`,
          message: truncate(errMsg),
        })
      }
    },
  }
}
