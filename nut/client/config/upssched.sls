# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import nut with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

{%- set sls_client_package_install = tplroot ~ '.client.package.install' %}

include:
  - {{ sls_client_package_install }}

nut-client-config-upssched-file-managed:
  file.managed:
    - name: {{ nut.config_dir }}/{{ nut.client.upssched.config.file }}
    - source: {{ files_switch(['upssched-conf.jinja'],
                              lookup='nut-client-config-upssched-file-managed'
                             )
              }}
    - mode: 640
    - user: {{ nut.user }}
    - group: {{ nut.group }}
    - makedirs: true
    - template: jinja
    - require:
      - sls: {{ sls_client_package_install }}
    - context:
        nut: {{ nut | json }}
