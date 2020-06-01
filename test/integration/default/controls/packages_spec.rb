# frozen_string_literal: true

control 'nut packages' do
  title 'should be installed'

  package_names =
    case platform[:family]
    when 'debian'
      %w[
        nut-server
        nut-client
      ]
    when 'redhat', 'fedora'
      %w[
        nut
        nut-client
      ]
    when 'suse'
      %w[
        nut
      ]
    # Catch remaining `linux` platforms to identify by `name` at the end
    when 'linux'
      case platform[:name]
      when 'arch'
        %w[
          nut
          nut-client
        ]
      end
    end
  package_names.each do |p|
    describe package(p) do
      it { should be_installed }
    end
  end
end
