# Name: pdftk-java
# Website: https://gitlab.com/pdftk-java/pdftk
# Description: Edit, create, and examine PDF files.
# Category: Analyze Documents: PDF
# Author: Marc Vinyals
# License: GNU General Public License (GPL) v2: https://gitlab.com/pdftk-java/pdftk/-/blob/master/LICENSE
# Notes: pdftk

{%- if grains['oscodename'] == "bionic" %}
include:
  - remnux.repos.remnux

pdftk-java:
  pkg.installed

{%- elif grains['oscodename'] == "focal" %}
pdftk-java:
  pkg.installed

{% endif %}
