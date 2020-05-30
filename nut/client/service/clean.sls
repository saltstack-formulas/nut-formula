# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import nut with context %}

nut-client-service-clean-upsmon-service-dead:
  service.dead:
    - name: {{ nut.client.upsmon.service.name }}
    - enable: False
