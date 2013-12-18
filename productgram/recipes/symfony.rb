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

  directory "#{deploy[:deploy_to]}/current/Symfony/app/cache" do
    owner "#{deploy[:user]}"
    group "#{deploy[:group]}"
    mode "777"
    recursive true
    action :create
  end

  directory "#{deploy[:deploy_to]}/current/Symfony/app/logs" do
    owner "#{deploy[:user]}"
    group "#{deploy[:group]}"
    mode "777"
    recursive true
    action :create
  end

  script "set_cache_log_permissions" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current/Symfony"
    code <<-EOH
       sudo chmod -R 777 app/logs
       sudo chmod -R 777 app/cache
    EOH
  end

end