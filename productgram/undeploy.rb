define :undeploy do
  apache = params[:apache_data]
  application = params[:app]
  deploy = params[:deploy_data]

  link "#{apache[:dir]}/sites-enabled/#{application}.conf" do
    action :delete
    only_if do
      ::File.exists?("#{apache[:dir]}/sites-enabled/#{application}.conf")
    end
  end

  file "#{apache[:dir]}/sites-available/#{application}.conf" do
    action :delete
    only_if do
      ::File.exists?("#{apache[:dir]}/sites-available/#{application}.conf")
    end
  end

  directory "#{deploy[:deploy_to]}" do
    recursive true
    action :delete
    only_if do
      ::File.exists?("#{deploy[:deploy_to]}")
    end
  end

end