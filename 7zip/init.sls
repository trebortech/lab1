{% set zipversion = pillar.get('version', '9.20.00.0') %}

"Install 7Zip":
  pkg.installed:
    - name: 7zip
    - version: {{ zipversion }}
    - reinstall: True
