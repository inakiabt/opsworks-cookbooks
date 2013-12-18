include_recipe "symfony2"

node[:deploy].each do |application, deploy|

  template "/etc/php.d/timezone.ini" do
      source "timezone.erb"
      owner "root"
      mode "0755"
  end

  path = "#{deploy[:deploy_to]}/current/Symfony"
  # Deletes hard copied bundles
  directory "#{path}/web/bundles" do
    recursive true
    action :delete
  end

  symfony2_console "assets:install" do
    action :cmd
    env "prod"
    command "assets:install --symlink"
    path path
  end

  symfony2_console "assetic:dump" do
    action :cmd
    env "prod"
    command "assetic:dump"
    path path
  end

  symfony2_console "cache:clear" do
    action :cmd
    env "prod"
    command "cache:clear"
    path path
  end

  symfony2_console "cache:warmup" do
    action :cmd
    env "prod"
    command "cache:warmup"
    path path
  end


#   script "set_cache_log_permissions" do
#     interpreter "bash"
#     user "#{deploy[:user]}"
#     group "#{deploy[:group]}"
#     cwd "#{deploy[:deploy_to]}/current/Symfony"
#     code <<-EOH
#       php app/console assets:install --env=prod
#       php app/console assetic:dump --env=prod
#     EOH
# #      sudo setfacl -R -m u:#{deploy[:group]}:rwX -m u:#{deploy[:user]}:rwX app/cache app/logs
# #      sudo setfacl -dR -m u:#{deploy[:group]}:rwx -m u:#{deploy[:user]}:rwx app/cache app/logs
#   end

#   directory "#{deploy[:deploy_to]}/current/Symfony/app/cache" do
#     owner "#{deploy[:user]}"
#     group "#{deploy[:group]}"
#     recursive true
#     mode "777"
#   end

#   directory "#{deploy[:deploy_to]}/current/Symfony/app/logs" do
#     owner "#{deploy[:user]}"
#     group "#{deploy[:group]}"
#     recursive true
#     mode "777"
#   end

end