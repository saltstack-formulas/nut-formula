# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import nut with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

{%- set sls_client_service_clean = tplroot ~ '.client.service.clean' %}

include:
  - {{ sls_client_service_clean }}

nut-client-config-mode-file-absent:
  file.absent:
    - name: {{ nut.config_dir }}/{{ nut.config }}
    - require:
      - sls: {{ sls_client_service_clean }}

nut-client-config-upsmon-file-absent:
  file.absent:
    - name: {{ nut.config_dir }}/{{ nut.client.upsmon.config.file }}
    - require:
      - sls: {{ sls_client_service_clean }}

nut-client-config-upssched-file-absent:
  file.absent:
    - name: {{ nut.config_dir }}/{{ nut.client.upssched.config.file }}
    - require:
      - sls: {{ sls_client_service_clean }}
