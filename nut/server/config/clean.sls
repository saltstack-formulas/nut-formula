# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import nut with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

{%- set sls_server_service_clean = tplroot ~ '.server.service.clean' %}
{%- set sls_server_driver_clean = tplroot ~ '.server.driver.clean' %}

include:
  - {{ sls_server_service_clean }}
  - {{ sls_server_driver_clean }}

nut-server-config-mode-file-absent:
  file.absent:
    - name: {{ nut.config_dir }}/{{ nut.config }}
    - require:
      - sls: {{ sls_server_service_clean }}
      - sls: {{ sls_server_driver_clean }}

nut-server-config-upsd-file-absent:
  file.absent:
    - name: {{ nut.config_dir }}/{{ nut.server.upsd.config.file }}
    - require:
      - sls: {{ sls_server_service_clean }}
      - sls: {{ sls_server_driver_clean }}

nut-server-config-ups-file-absent:
  file.absent:
    - name: {{ nut.config_dir }}/{{ nut.server.ups.config.file }}
    - require:
      - sls: {{ sls_server_service_clean }}
      - sls: {{ sls_server_driver_clean }}

nut-server-config-users-file-absent:
  file.absent:
    - name: {{ nut.config_dir }}/{{ nut.server.users.config.file }}
    - require:
      - sls: {{ sls_server_service_clean }}
      - sls: {{ sls_server_driver_clean }}
