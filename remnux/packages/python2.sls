{% set package_name = salt['grains.filter_by']({
  'bionic': 'python',
  'focal': 'python2'
}, grain='oscodename') %}

remnux-packages-python2:
  pkg.installed:
    - name: {{ package_name }}
