# Name: Mermaid Viewer
# Command: mermaid-view
# Website: https://mermaid.js.org/
# Description: View Mermaid diagrams, such as AI-generated code-analysis workflow diagrams, in a local browser.
# Category: View or Edit Files
# Author: Mermaid.js contributors: https://github.com/mermaid-js/mermaid
# License: MIT License: https://github.com/mermaid-js/mermaid/blob/develop/LICENSE
# Notes: mermaid-view. Renders offline with `mermaid-view diagram.mmd`; needs a graphical browser, so it does not work on headless installs.

{% set version = '11.16.0' %}
{% set hash = '74d7c46dabca328c2294733910a8aa1ed0c37451776e8d5295da38a2b758fb9b' %}

include:
  - remnux.packages.firefox
  - remnux.packages.xdg-utils

remnux-tools-mermaid-view-bundle:
  file.managed:
    - name: /usr/local/mermaid-view/mermaid.min.js
    - source: https://cdn.jsdelivr.net/npm/mermaid@{{ version }}/dist/mermaid.min.js
    - source_hash: sha256={{ hash }}
    - makedirs: True
    - mode: 644

remnux-tools-mermaid-view-wrapper:
  file.managed:
    - name: /usr/local/bin/mermaid-view
    - mode: 755
    - require:
      - file: remnux-tools-mermaid-view-bundle
      - pkg: xdg-utils
    - contents: |
        #!/usr/bin/env bash
        # Render a Mermaid diagram to a fully self-contained local HTML page and
        # open it in the default browser. On Ubuntu/REMnux the browser is a snap
        # (Firefox), which runs in a private mount namespace and cannot read /tmp
        # or /usr/local. So the Mermaid renderer is inlined into the page (no
        # external file reference) and the page is written where the browser snap
        # can read it. Rendering is offline under a network-blocking CSP with
        # Mermaid securityLevel strict; the diagram source is base64-embedded in
        # the page body, so there is no URL-length limit.
        set -euo pipefail

        readonly BUNDLE='/usr/local/mermaid-view/mermaid.min.js'

        usage() {
            printf 'Usage: %s DIAGRAM.mmd\n' "${0##*/}" >&2
            printf 'Renders a Mermaid diagram and opens it in your default browser.\n' >&2
        }

        if [[ $# -ne 1 ]]; then
            usage
            exit 64
        fi

        input=$1

        if [[ ! -f "$input" ]]; then
            printf 'mermaid-view: not a regular file: %s\n' "$input" >&2
            exit 66
        fi

        if [[ ! -r "$input" ]]; then
            printf 'mermaid-view: cannot read file: %s\n' "$input" >&2
            exit 66
        fi

        if [[ ! -r "$BUNDLE" ]]; then
            printf 'mermaid-view: renderer not installed: %s\n' "$BUNDLE" >&2
            exit 69
        fi

        # A snap-confined Firefox can read files under its own common dir but not
        # /tmp or /usr/local; fall back to a non-hidden dir in HOME otherwise.
        if [[ -d "$HOME/snap/firefox/common" ]]; then
            outdir="$HOME/snap/firefox/common/mermaid-view"
        else
            outdir="$HOME/mermaid-view"
        fi

        mkdir -p "$outdir"
        rm -f "$outdir"/mermaid.*.html 2>/dev/null || true
        out=$(mktemp -p "$outdir" --suffix=.html mermaid.XXXXXX)

        encoded=$(base64 --wrap=0 -- "$input")

        {
            cat <<'HTMLHEAD'
        <!doctype html>
        <html lang="en">
        <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Security-Policy" content="default-src 'none'; script-src 'unsafe-inline'; style-src 'unsafe-inline'; img-src data:">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Mermaid diagram</title>
        <style>
        body { margin: 0; padding: 2rem; background: #fff; font-family: sans-serif; }
        #diagram { display: flex; justify-content: center; overflow: auto; }
        #diagram svg { max-width: 100%; height: auto; }
        #error { white-space: pre-wrap; color: #a00; }
        </style>
        </head>
        <body>
        <div id="diagram"></div>
        <pre id="error"></pre>
        <script>
        HTMLHEAD
            cat -- "$BUNDLE"
            cat <<HTMLTAIL
        </script>
        <script type="text/plain" id="src">${encoded}</script>
        <script>
        "use strict";
        mermaid.initialize({ startOnLoad: false, securityLevel: "strict", suppressErrorRendering: true });
        async function renderDiagram() {
          try {
            const encodedSource = document.getElementById("src").textContent.trim();
            if (!encodedSource) { throw new Error("No Mermaid diagram was supplied."); }
            const bytes = Uint8Array.from(atob(encodedSource), c => c.charCodeAt(0));
            const source = new TextDecoder().decode(bytes);
            const result = await mermaid.render("mermaid-diagram", source);
            document.getElementById("diagram").innerHTML = result.svg;
          } catch (error) {
            document.getElementById("error").textContent = error instanceof Error ? error.message : String(error);
          }
        }
        renderDiagram();
        </script>
        </body>
        </html>
        HTMLTAIL
        } > "$out"

        xdg-open "file://${out}" >/dev/null 2>&1
