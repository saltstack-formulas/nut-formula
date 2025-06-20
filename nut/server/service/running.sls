# -*- coding: utf-8 -*-
# vim: ft=sls

{%- from "nut/map.jinja" import nut as nutmap with context %}

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_file = tplroot ~ '.config.file' %}
{%- from tplroot ~ "/map.jinja" import nut with context %}

{%- set sls_server_config_mode = tplroot ~ '.server.config.mode' %}
{%- set sls_server_config_ups = tplroot ~ '.server.config.ups' %}
{%- set sls_server_config_upsd = tplroot ~ '.server.config.upsd' %}
{%- set sls_server_config_users = tplroot ~ '.server.config.users' %}

include:
  - {{ sls_server_config_mode }}
  - {{ sls_server_config_ups }}
  - {{ sls_server_config_upsd }}
  - {{ sls_server_config_users }}

{%- for svc in nutmap.server.ups.services %}
nut-server-service-running-ups-service-running-{{ loop.index }}:
  service.running:
    - name: {{ svc.name }}
    - enable: {{ svc.enabled }}
    - watch:
      - sls: {{ sls_server_config_mode }}
      - sls: {{ sls_server_config_ups }}
      - sls: {{ sls_server_config_upsd }}
      - sls: {{ sls_server_config_users }}
    # If the mode is 'none' we respect the package and do nothing
    - unless: test "{{ nutmap.mode }}" = "none"
{%- endfor %}

nut-server-service-running-upsd-service-running:
  service.running:
    - name: {{ nut.server.upsd.service.name }}
    - enable: {{ nut.server.upsd.service.enabled }}
    - watch:
      - sls: {{ sls_server_config_mode }}
      - sls: {{ sls_server_config_ups }}
      - sls: {{ sls_server_config_upsd }}
      - sls: {{ sls_server_config_users }}
    # If the mode is 'none' we respect the package and do nothing
    - unless: test "{{ nut.mode }}" = "none"
