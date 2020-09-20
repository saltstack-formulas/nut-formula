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
    its('content') { should match '^MODE=none' }
  end
end
