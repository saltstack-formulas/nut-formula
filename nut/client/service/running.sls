# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_file = tplroot ~ '.config.file' %}
{%- from tplroot ~ "/map.jinja" import nut with context %}

{%- set sls_client_config_upsmon = tplroot ~ '.client.config.upsmon' %}

include:
  - {{ sls_client_config_upsmon }}

nut-client-service-running-upsmon-service-running:
  service.running:
    - name: {{ nut.client.upsmon.service.name }}
    - enable: {{ nut.client.upsmon.service.enabled }}
    - watch:
      - sls: {{ sls_client_config_upsmon }}
    # If the mode is 'none' we respect the package and do nothing
    - unless: test "{{ nut.mode }}" = "none"
