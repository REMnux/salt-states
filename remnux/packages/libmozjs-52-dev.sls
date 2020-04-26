# Name: SpiderMonkey
# Website: https://developer.mozilla.org/en-US/docs/Mozilla/Projects/SpiderMonkey
# Description: Execute and deobfuscate JavaScript using Mozilla's standalone JavaScript engine
# Category: Script Analysis and Deobfuscation
# Author: Mozilla Foundation
# License: https://github.com/mozilla/treeherder/blob/master/LICENSE.txt
# Notes: js

libmozjs-52-dev:
  pkg.installed

/usr/bin/js:
  file.symlink:
    - target: /usr/bin/js52