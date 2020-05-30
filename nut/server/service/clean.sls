# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import nut with context %}

nut-server-service-clean-upsd-service-dead:
  service.dead:
    - name: {{ nut.server.upsd.service.name }}
    - enable: False

nut-server-service-clean-ups-service-dead:
  service.dead:
    - name: {{ nut.server.ups.service.name }}
    - enable: False
