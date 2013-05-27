node[:deploy].each do |application, deploy|

  template "#{deploy[:deploy_to]}/Symfony/web/ping.html" do
      source "ping.erb"
      owner deploy[:user]
      mode "0755"
  end

end
