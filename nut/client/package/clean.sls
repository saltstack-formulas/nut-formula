# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_clean = tplroot ~ '.client.config.clean' %}
{%- from tplroot ~ "/map.jinja" import nut with context %}

include:
  - {{ sls_config_clean }}

nut-client-package-install-pkgs-removed:
  pkg.removed:
    - pkgs: {{ nut.client.pkgs }}
    - require:
      - sls: {{ sls_config_clean }}
