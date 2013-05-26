node[:deploy].each do |application, deploy|

  template "/etc/php.d/timezone.ini" do
      source "timezone.erb"
      owner "root"
      mode "0755"
  end

  script "set_cache_log_permissions" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current"
    code <<-EOH
      sudo setfacl -R -m u:#{deploy[:group]}:rwX -m u:#{deploy[:user]}:rwX Symfony/app/cache Symfony/app/logs
      sudo setfacl -dR -m u:#{deploy[:group]}:rwx -m u:#{deploy[:user]}:rwx Symfony/app/cache Symfony/app/logs
    EOH
  end

end
