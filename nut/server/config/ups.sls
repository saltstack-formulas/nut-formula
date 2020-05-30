# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import nut with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

{%- set sls_server_package_install = tplroot ~ '.server.package.install' %}

include:
  - {{ sls_server_package_install }}

nut-server-config-ups-file-managed:
  file.managed:
    - name: {{ nut.config_dir }}/{{ nut.server.ups.config.file }}
    - source: {{ files_switch(['ups-conf.jinja'],
                              lookup='nut-server-config-ups-file-managed'
                             )
              }}
    - mode: 640
    - user: {{ nut.user }}
    - group: {{ nut.group }}
    - makedirs: true
    - template: jinja
    - require:
      - sls: {{ sls_server_package_install }}
    - context:
        nut: {{ nut | json }}
