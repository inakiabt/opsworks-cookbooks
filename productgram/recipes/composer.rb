include_recipe "composer"

node[:deploy].each do |app_name, deploy|

	composer "/usr/local/bin" do
	  #owner "root" # optional
	  action [:install]
	end

	composer_project "#{deploy[:deploy_to]}/current/Symfony" do
		run_as "#{node[:apache][:user]}"
		#group "#{deploy[:group]}"
		quiet false
	 	action [:install, :update]
	end

end
