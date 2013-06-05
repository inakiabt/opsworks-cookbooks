include_recipe "composer"

node[:deploy].each do |app_name, deploy|

	composer "/usr/local/bin" do
	  owner "root" # optional
	  action [:install]
	end

	composer_project "#{deploy[:deploy_to]}/current/Symfony" do
	 action [:update]
	end
  # script "install_composer" do
  #   interpreter "bash"
  #   user "root"
  #   cwd "#{deploy[:deploy_to]}/current/Symfony"
  #   code <<-EOH
  #   curl -s https://getcomposer.org/installer | php
  #   php composer.phar install
  #   EOH
  # end

end
