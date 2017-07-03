# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "nut/map.jinja" import nut with context %}
{% set ups_config = nut.server.ups if nut.server.ups is defined else {} %}
{% set upsd_config = nut.server.upsd.config if nut.server.upsd.config is defined else {} %}
{% set upsd_users = nut.server.users.users if nut.server.users.users is defined else {} %}

include:
  - nut.mode

nut_server:
  pkg.installed:
    - name: {{ nut.server.pkg }}
    - require_in:
      - file: nut_conf

ups_conf:
  file.managed:
    - name: {{ nut.config_dir }}/{{ nut.server.ups.config }}
    - source: salt://nut/templates/ups-conf.jinja
    - context:
        ups: {{ ups_config }}
    - template: jinja
    - mode: 640
    - user: root
    - group: nut
    - require:
      - pkg: nut_server
    - require_in:
      - service: upsd_service
    - watch_in:
      - service: upsd_service

upsd_conf:
  file.managed:
    - name: {{ nut.config_dir }}/{{ nut.server.upsd.config }}
    - source: salt://nut/templates/upsd-conf.jinja
    - context:
        upsd: {{ upsd_config }}
    - template: jinja
    - mode: 640
    - user: root
    - group: nut
    - require:
      - pkg: nut_server
    - require_in:
      - service: upsd_service
    - watch_in:
      - service: upsd_service

upsd_users:
  file.managed:
    - name: {{ nut.config_dir }}/{{ nut.server.users.config}}
    - source: salt://nut/templates/upsd-users.jinja
    - context:
        users: {{ upsd_users }}
    - template: jinja
    - mode: 640
    - user: root
    - group: nut
    - require:
      - pkg: nut_server
    - require_in:
      - service: upsd_service
    - watch_in:
      - service: upsd_service

upsd_service:
  service.running:
    - name: {{ nut.server.upsd.service }}
    - enable: {{ nut.server.upsd.enabled }}
    - require:
      - pkg: nut_server
