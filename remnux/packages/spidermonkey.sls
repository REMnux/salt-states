# Name: SpiderMonkey
# Website: https://developer.mozilla.org/en-US/docs/Mozilla/Projects/SpiderMonkey
# Description: Execute and deobfuscate JavaScript using Mozilla's standalone JavaScript engine.
# Category: Dynamically Reverse-Engineer Code: Scripts
# Author: Mozilla Foundation
# License: Mozilla Public License 2.0: https://github.com/mozilla/treeherder/blob/master/LICENSE.txt
# Notes: js

{% if grains['oscodename'] == "focal" %}
{% set pkg = 'libmozjs-52-dev' %}
{% set ver = '52' %}
{% elif grains['oscodename'] == "noble" %}
{% set pkg = 'libmozjs-115-dev' %}
{% set ver = '115' %}
{% endif %}

{{ pkg }}:
  pkg.installed

remnux-packages-spidermonkey-config:
  alternatives.install:
    - name: js
    - link: /usr/bin/js
    - path: /usr/bin/js{{ ver }}
    - priority: 300
    - watch:
      - pkg: {{ pkg }}
