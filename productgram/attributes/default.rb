include_attribute 'deploy'

default[:symfony2][:user]  = node[:deploy][:user]
default[:symfony2][:group] = node[:apache][:group]