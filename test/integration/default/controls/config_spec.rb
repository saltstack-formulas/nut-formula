# frozen_string_literal: true

config_dir = '/etc/nut'
config_dir = '/etc/ups' if %w[redhat fedora suse].include? os.family

nut_user =  nut_group = 'nut'
nut_user =  nut_group = 'upsd' if %w[suse].include? os.family

control 'nut configuration' do
  title 'should match desired lines'

  describe file("#{config_dir}/nut.conf") do
    it { should be_file }
    it { should be_owned_by nut_user }
    it { should be_grouped_into nut_group }
    its('mode') { should cmp '0640' }
    its('content') { should include '# Your changes will be overwritten.' }
    its('content') { should match '^MODE=standalone' }
  end

  describe file("#{config_dir}/ups.conf") do
    it { should be_file }
    it { should be_owned_by nut_user }
    it { should be_grouped_into nut_group }
    its('mode') { should cmp '0640' }
    its('content') { should include '# Your changes will be overwritten.' }
    its('content') { should include 'maxretry = 3' }
    its('content') { should include 'retrydelay = 1' }
    its('content') do
      should include
      <<~UPS
        [ups1]
          desc = Dummy server 1
          driver = dummy-ups
          port = /dev/null
        [ups2]
          desc = Dummy server 2
          driver = dummy-ups
          port = /dev/null
      UPS
    end
  end

  describe file("#{config_dir}/upsd.conf") do
    it { should be_file }
    it { should be_owned_by nut_user }
    it { should be_grouped_into nut_group }
    its('mode') { should cmp '0640' }
    its('content') { should include '# Your changes will be overwritten.' }
    unless %w[suse].include? os.family
      its('content') { should include 'STATEPATH /run/nut' }
    end
    its('content') { should include 'MAXAGE 20' }
    its('content') { should include 'LISTEN 127.0.0.1 3493' }
    its('content') { should include 'LISTEN ::1 3493' }
    its('content') { should include 'MAXCONN 100' }
  end

  describe file("#{config_dir}/upsd.users") do
    it { should be_file }
    it { should be_owned_by nut_user }
    it { should be_grouped_into nut_group }
    its('mode') { should cmp '0640' }
    its('content') { should include '# Your changes will be overwritten.' }
    its('content') do
      should include
      <<~UPSUSERS
        [ups_monitor_user]
            actions = SET FSD
            instcmds = ALL
            password = ups
            upsmon master
      UPSUSERS
    end
  end

  describe file("#{config_dir}/upsmon.conf") do
    it { should be_file }
    it { should be_owned_by nut_user }
    it { should be_grouped_into nut_group }
    its('mode') { should cmp '0640' }
    its('content') { should include '# Your changes will be overwritten.' }
    its('content') { should include "RUN_AS_USER #{nut_user}" }
    # rubocop:disable Metrics/LineLength
    its('content') { should include 'MONITOR ups1@localhost 1 ups_monitor_user ups master' }
    its('content') { should include 'MONITOR ups2@localhost 1 ups_monitor_user ups master' }
    # rubocop:enable Metrics/LineLength
    its('content') { should include 'MINSUPPLIES 2' }
    its('content') { should include 'SHUTDOWNCMD "/some/shutdown/script"' }
    its('content') { should include 'NOTIFYCMD /some/notify/script' }
    its('content') { should include 'POLLFREQ 10' }
    its('content') { should include 'POLLFREQALERT 10' }
    its('content') { should include 'HOSTSYNC 30' }
    its('content') { should include 'DEADTIME 30' }
    its('content') { should include 'POWERDOWNFLAG illkillyou' }
    its('content') { should include 'NOTIFYMSG ONBATT "an on battery message"' }
    its('content') { should include 'NOTIFYMSG ONLINE "some online message"' }
    its('content') { should include 'NOTIFYFLAG COMMOK IGNORE' }
    its('content') { should include 'NOTIFYFLAG REPLBATT SYSLOG+WALL+EXEC' }
    its('content') { should include 'RBWARNTIME 55555' }
    its('content') { should include 'NOCOMMWARNTIME 666' }
    its('content') { should include 'FINALDELAY 30' }
    its('content') { should include 'CERTVERIFY 0' }
    its('content') { should include 'FORCESSL 0' }
  end

  describe file("#{config_dir}/upssched.conf") do
    it { should be_file }
    it { should be_owned_by nut_user }
    it { should be_grouped_into nut_group }
    its('mode') { should cmp '0640' }
    its('content') { should include '# Your changes will be overwritten.' }
    its('content') { should include 'CMDSCRIPT /some/upssched/cmd' }
    its('content') { should include 'AT COMMOK ups@localhost CANCEL-TIMER upsgone' }
    its('content') { should include 'AT COMMBAD * START-TIMER upsgone 10' }
    its('content') { should include 'AT ONLINE * EXECUTE ups-back-on-line' }
  end
end
