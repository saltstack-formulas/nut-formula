# frozen_string_literal: true

control 'nut-server service' do
  impact 0.5
  title 'should not be running'

  describe service('nut-server') do
    it { should_not be_running }
  end
end

control 'nut-monitor service' do
  impact 0.5
  title 'should not be running'

  describe service('nut-monitor') do
    it { should_not be_running }
  end
end
