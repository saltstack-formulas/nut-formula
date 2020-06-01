# -*- coding: utf-8 -*-
# vim: ft=yaml
---
nut:
  # by the distros packages.
  config: nut.conf

  mode: standalone

  server:
    ups:
      config:
        maxretry: 3
        retrydelay: 1
        units:
          ups1:
            driver: dummy-ups
            port: /dev/null
            desc: Dummy server 1
          ups2:
            driver: dummy-ups
            port: /dev/null
            desc: Dummy server 2
    upsd:
      config:
        maxage: 20
        {%- if grains.os_family not in ('Suse',) %}
        statepath: /run/nut
        {%- endif %}

        listen:
          - '127.0.0.1 3493'
          - '127.0.0.3 3493'
        max_connections: 100

    ### USERS WITH ACCESS TO UPSD
    users:
      config:
        users:
          ups_monitor_user:
            password: ups
            actions: SET FSD
            instcmds: ALL
            upsmon: master

  client:
    upsmon:
      config:
        {%- if grains.os_family in ('Suse',) %}
        run_as_user: upsd
        {% else %}
        run_as_user: nut
        {% endif %}
        minsupplies: 2
        shutdowncmd: /some/shutdown/script
        notifycmd: /some/notify/script
        pollfreq: 10
        pollfreqalert: 10
        hostsync: 30
        deadtime: 30
        powerdownflag: illkillyou
        notifymsg:
          online: some online message
          onbatt: an on battery message
        notifyflag:
          replbatt: SYSLOG+WALL+EXEC
          commok: IGNORE
        rbwarntime: 55555
        nocommwarntime: 666
        finaldelay: 30
        certverify: 0
        forcessl: 0

        monitor:
          ups1:
            system: ups1@localhost
            username: ups_monitor_user
            password: ups
          ups2:
            system: ups2@localhost
            username: ups_monitor_user
            password: ups

    upssched:
      config:
        cmdscript: /some/upssched/cmd
        at:
          - COMMOK ups@localhost CANCEL-TIMER upsgone
          - COMMBAD * START-TIMER upsgone 10
          - ONLINE * EXECUTE ups-back-on-line
