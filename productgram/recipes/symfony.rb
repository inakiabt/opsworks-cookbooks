  template "/etc/php.d/timezone.ini" do
      source "timezone.erb"
      owner "root"
      mode "0755"
  end


node[:deploy].each do |app_name, deploy|


  script "set_cache_log_permissions" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current"
    code <<-EOH
      sudo setfacl -R -m u:#{deploy[:user]}:rwX -m u:#{deploy[:group]}:rwX app/cache app/logs
      sudo setfacl -dR -m u:#{deploy[:user]}:rwx -m u:#{deploy[:group]}:rwx app/cache app/logs
    EOH
  end

end
