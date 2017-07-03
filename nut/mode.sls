# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "nut/map.jinja" import nut with context %}

nut_conf:
  file.managed:
    - name: {{ nut.config_dir }}/{{ nut.config }}
    - source: salt://nut/templates/nut-conf.jinja
    - context:
        mode: {{ nut.mode }}
    - template: jinja
    - mode: 640
    - user: root
    - group: nut

