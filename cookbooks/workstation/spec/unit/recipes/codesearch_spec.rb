#
# Cookbook Name:: workstation
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'workstation::codesearch' do
  context 'When all attributes are default, on Mac OS X' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'mac_os_x', version: '10.11.1')
      runner.converge(described_recipe)
    end

    before(:each) do
      allow_any_instance_of(Chef::Resource).to receive(:workstation_user).and_return('vagrant')
      allow_any_instance_of(Chef::Recipe).to receive(:workstation_user).and_return('vagrant')
      allow_any_instance_of(Chef::Resource).to receive(:workstation_user_home).and_return('/Users/vagrant')
      allow_any_instance_of(Chef::Recipe).to receive(:workstation_user_home).and_return('/Users/vagrant')
      allow(File).to receive(:exist?).and_return(false)
    end

    it 'converges successfully' do
      expect { chef_run  }.to_not raise_error
    end
  end
end
