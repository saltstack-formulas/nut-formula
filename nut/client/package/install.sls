# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import nut with context %}

nut-client-package-install-pkgs-installed:
  pkg.installed:
    - pkgs: {{ nut.client.pkgs }}
