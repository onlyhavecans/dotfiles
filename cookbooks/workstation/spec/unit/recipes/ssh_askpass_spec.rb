#
# Cookbook Name:: workstation
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'workstation::ssh_askpass' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'mac_os_x', version: '10.11.1')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run  }.to_not raise_error
    end
  end
end
