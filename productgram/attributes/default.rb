include_attribute 'deploy'

default[:symfony2][:user]  = node[:apache][:user]
default[:symfony2][:group] = node[:apache][:group]