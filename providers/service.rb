action :enable do

	if not ::File.exists? "/etc/default/sphinxsearch"
		File "/etc/default/sphinxsearch" do
			content "START=yes"
		end
	else
		execute "Change START in /etc/default/sphinxsearch" do
			command "sed -i 's/start.*=.*no/START=yes/i' /etc/default/sphinxsearch"
		end
	end

	case node["platform_family"]
	when "rhel"
		log "not implemented for rhel family"

	when "debian"
		execute "update-rc.d sphinxsearch defaults"

	else
		log "For this platform this action is not fully supported"
	end

end


action :disable do
	if ::File.exists? "/etc/default/sphinxsearch"
		execute "sed -i 's/start.*=.*yes/START=no/i' /etc/default/sphinxsearch"
	end

	case node["platform_family"]
	when "rhel"
		log "not implemented for rhel family"

	when "debian"
		execute "update-rc.d -f sphinxsearch remove"

	else
		log "For this platform this action is not fully supported"
	end

end


action :start do
	
	case node["platform_family"]
	when "debian"
		execute "service sphinxsearch start"
	else
		execute "/etc/init.d/sphinxsearch start"
	end

end


action :stop do

	case node["platform_family"]
	when "debian"
		execute "service sphinxsearch stop"
	else
		execute "/etc/init.d/sphinxsearch stop"
	end

end
