# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "nut/map.jinja" import nut with context %}
{% set ups_config_dir = nut.config_dir if nut.config_dir is defined else '/etc/nut' %}
{% set ups_monitor = nut.client.monitor if nut.client.monitor is defined else {} %}

include:
  - nut.mode

nut_client:
  pkg.installed:
    - name: {{ nut.client.pkg }}
    - require_in:
      - file: nut_conf

  file.managed:
    - name: {{ nut.config_dir }}/{{ nut.client.config }}
    - source: salt://nut/templates/upsmon-conf.jinja
    - context:
      config_dir: {{ ups_config_dir }}
      upsmon: {{ ups_monitor }}
    - template: jinja
    - mode: 640
    - user: root
    - group: nut
    - require:
      - pkg: nut_client
    - watch_in:
      - service: nut_client

  service.running:
    - name: {{ nut.client.service }}
    - enable: {{ nut.client.enabled }}
    - require:
      - pkg: nut_client
