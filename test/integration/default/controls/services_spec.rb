# frozen_string_literal: true

control 'nut-server service' do
  impact 0.5
  title 'should be running and enabled'

  describe service('nut-server') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(3493) do
    its('processes') { should include 'upsd' }
    its('protocols') { should include 'tcp' }
    its('addresses') { should include '127.0.0.1' }
    its('addresses') { should include '127.0.0.3' }
  end
end

control 'nut-monitor service' do
  impact 0.5
  title 'should be running and enabled'

  describe service('nut-monitor') do
    it { should be_enabled }
    it { should be_running }
  end
end
