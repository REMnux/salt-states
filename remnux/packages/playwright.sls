{% set version = '1.57.0' %}

include:
  - remnux.packages.nodejs

remnux-packages-playwright-npm:
  npm.installed:
    - name: playwright@{{ version }}
    - require:
      - sls: remnux.packages.nodejs

remnux-packages-playwright-chromium:
  cmd.run:
    - name: playwright install --with-deps chromium && touch /opt/ms-playwright/.chromium-installed-{{ version }}
    - env:
      - PLAYWRIGHT_BROWSERS_PATH: /opt/ms-playwright
    - unless: test -f /opt/ms-playwright/.chromium-installed-{{ version }}
    - require:
      - npm: remnux-packages-playwright-npm
