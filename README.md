Required
========

- VirtualBox {https://www.virtualbox.org/}
- Vagrant {http://vagrantup.com/}
- Ruby {http://www.ruby-lang.org/en/downloads}
- RubyGems {http://rubygems.org/pages/download}
- Rake {http://rubygems.org/gems/rake}

Optional (for deployments)
==========================

- PIP {http://www.pip-installer.org}

------------------------------------------------------------------------------------

Setup (local dev)
=================

The below will download the bare repo, install the base requirements, and boot a vm.

    git clone git@github.com:streamlinesocial/local-dev-env.git <FOLDER NAME>
    cd <FOLDER NAME>
    rake init
    rake vm:up

Usage (local dev)
=================

The "vm" namespace in the rake task shows most of the vagrant commands to control the
environment. You can boot (up), shutdown (halt), configure (provision) the env. Daily
you would probably just boot the machine and halt it when your done.

    rake vm:up
    rake vm:halt
    rake vm:status

Shared folders can be used (defined in the Vagrantfile) to enable a share between the
guest and host.

------------------------------------------------------------------------------------

Vagrant
=======

The Vagrantfile included will look to the nodes/ folder for the chef run list. If
you would rather, you can use littlechef, but the purpose of the Vagrantfile tweak
is to get Vagrant running chef just like littlechef would be.

------------------------------------------------------------------------------------

Setup (server deploy)
=====================

The below will download the bare repo, install the base requirements, and boot a vm.

    git clone git@github.com:streamlinesocial/local-dev-env.git <FOLDER NAME>
    cd <FOLDER NAME>
    rake init:deploy
    rake vm:up


------------------------------------------------------------------------------------

Deploy
======

Use littlechef's fix command to deploy to a server. It's recommended to edit the
Rakefile and add a helper to make deployment a oneline rake task per env.

    # add user / pass for server
    vi config.cfg

    fix node:IPADDRESS deploy_chef
    fix node:IPADDRESS

That should run through the install, and deploy the app.
