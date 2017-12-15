module VagrantPlugins
	module Proxmox
		module Action

			# This action stores the ssh information in env[:machine_ssh_info]
			class ReadSSHInfo < ProxmoxAction

				def initialize app, env
					@app = app
					@logger = Log4r::Logger.new 'vagrant_proxmox::action::read_ssh_info'
				end

				def call env
					machine = env[:machine]
					env[:machine_ssh_info] = connection(env).get_ssh_host_ip(machine).try do |ip_address|
						{host: ip_address, port: env[:machine].config.ssh.guest_port}
					end
					env[:machine_ssh_info]
					next_action env
				end

			end

		end
	end
end
