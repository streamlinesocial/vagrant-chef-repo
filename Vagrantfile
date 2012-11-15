# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
    # Setup includes the chef-server among other things...
    # yum install chef-server
    config.vm.define :webserver do |webserver_config|
        webserver_config.vm.box = "strsocial-centos-6.3"
        webserver_config.vm.box_url = "http://files.streamlinesocial.com/vagrant/basebox/strsocial-centos-6.3.box"
        webserver_config.vm.customize ["modifyvm", :id, "--memory", 256]

        # setup the host name for the fqdn
        webserver_config.vm.host_name = 'local.dev'

        # use vagrant-hostmaster if we can
        webserver_config.hosts.aliases = %w(www.local.dev) if Vagrant.const_defined?(:Hostmaster)

        # required for nfs share
        webserver_config.vm.network :hostonly, "192.168.33.10"

        # list a folder here where project usually get deployed to
        # webserver_config.vm.share_folder "repos", "/var/www/vhosts", "./repos", :owner => "apache", :group => "apache", :create => true
        # webserver_config.vm.share_folder "server-vhosts", "/var/www/vhosts", "./srv", :nfs => true, :create => true

        # provision the virtual machine
        webserver_config.vm.provision :chef_solo do |chef|
            chef.cookbooks_path = ["cookbooks", 'site-cookbooks']
            chef.data_bags_path = "data_bags"
            chef.roles_path     = "roles"

            # setup to run the node for dev in the node list
            chef.add_role "note_dontAddToRunListInVagrantFile"
            node = JSON.parse(File.read(File.join(File.dirname(__FILE__), "nodes/local.dev.json")))
            node["run_list"] = node.delete("run_list")
            chef.json.merge!(node)
        end
    end
end
