node[:deploy].each do |application, deploy|

  template "/etc/php.d/timezone.ini" do
      source "timezone.erb"
      owner "root"
      mode "0755"
  end

  script "set_cache_log_permissions" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current/Symfony"
    code <<-EOH
      php app/console assets:install --env=prod
      php app/console assetic:dump --env=prod

      sudo setfacl -R -m u:#{deploy[:group]}:rwX -m u:#{deploy[:user]}:rwX app/cache app/logs
      sudo setfacl -dR -m u:#{deploy[:group]}:rwx -m u:#{deploy[:user]}:rwx app/cache app/logs
    EOH
  end

end
