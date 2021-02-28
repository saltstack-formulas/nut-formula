# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import nut with context %}

{%- if salt['grains.get']('osfinger', '') in ['Amazon Linux-2'] %}
nut_epel_repo:
  pkgrepo.managed:
    - name: epel
    - humanname: Extra Packages for Enterprise Linux 7 - $basearch
    - mirrorlist: https://mirrors.fedoraproject.org/metalink?repo=epel-7&arch=$basearch
    - enabled: 1
    - gpgcheck: 1
    - gpgkey: https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7
    - failovermethod: priority
    - require_in:
      - pkg: nut-server-package-install-pkgs-installed
      - pkg: nut-client-package-install-pkgs-installed
{%- endif %}

nut-server-package-install-pkgs-installed:
  pkg.installed:
    - pkgs: {{ nut.server.pkgs }}
