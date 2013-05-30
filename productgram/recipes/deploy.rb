include_recipe "deploy"
include_recipe "apache2::service"

must_restart_apache = false

node[:deploy].each do |application, deploy|

	if deploy[:application_type] != 'php'
		Chef::Log.debug("Skipping productgram::deploy application #{application} as it is not an PHP app")
		next
	end

	if !node[:opsworks][:instance][:hostname].start_with?(application)
		must_restart_apache = true
		undeploy do
			deploy_data deploy
			app application
			apache node[:apache]
		end
	end

end

if must_restart_apache == true
	service 'apache2' do
		action :restart
	end
end