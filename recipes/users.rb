#
# Cookbook Name:: defaults
# Recipe:: users
#
# Copyright (C) 2015 Leon Waldman
#
# All rights reserved - Do Not Redistribute
#

### Includes
include_recipe 'sudo'

### Action! o/
# Create groups
node['defaults']['user_groups'].each do | group_name, group_id |
  group group_name do
    action :create
    gid group_id
  end

  sudo group_name do
    user "%#{group_name}"
    nopasswd true
  end
end

# Create Users
node['defaults']['users'].each do | key, value |
  # Hash mapping
  user_name = key
  user_comment = value.comment
  user_groups = value.groups
  user_sshkeys = value.sshkeys
  user_uid = value.uid

  # User
  user key do
    action :create
    comment user_comment
    uid user_uid
  end
  
  # Group Setup
  user_groups.each do | user_group |
    group user_group do
      action :modify
      members key
      append true
    end
  end
  
  # SSH Key
  directory "/home/#{user_name}/.ssh" do
    action :create
    recursive true
    owner user_name
    group user_name
    mode '0700'
  end
  
  template "/home/#{user_name}/.ssh/authorized_keys" do
    action :create
    source 'users_authorized_keys.erb'
    variables({
      :sshkeys => user_sshkeys
    })
  end
end

# Fix for vagrant user
if node['etc']['passwd']['vagrant']
  sudo 'vagrant' do
    user 'vagrant'
    nopasswd true
  end

  group 'sudo' do
    action :modify
    members 'vagrant'
    append true
  end

  group 'sysadmin' do
    action :modify
    members 'vagrant'
    append true
  end
end
