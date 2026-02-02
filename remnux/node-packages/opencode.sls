# Name: OpenCode
# Website: https://opencode.ai
# Description: Open-source AI coding agent for the terminal.
# Category: Use Artificial Intelligence
# Author: Anomaly: https://github.com/anomalyco
# License: Apache License 2.0: https://github.com/anomalyco/opencode/blob/main/LICENSE
# Notes: OpenCode might come with a default model that's free, but that might use the data you supply for training. Consider changing the model to your own to ensure confidentiality.

include:
  - remnux.packages.nodejs

remnux-node-packages-opencode:
  npm.installed:
    - name: opencode-ai
    - require:
      - sls: remnux.packages.nodejs
