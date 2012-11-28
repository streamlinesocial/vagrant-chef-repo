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

Install deps
============

Install the required dependencies with the built in rake task

    rake install_deps

Usage
=====

The below will download the bare repo, install the base requirements, and boot a vm.

    git clone git@github.com:streamlinesocial/local-dev-env.git <FOLDER NAME>
    cd <FOLDER NAME>
    rake init
    vagrant up

Vagrant
=======

The Vagrantfile included will look to the nodes for the chef run list. If you would rather, you can use littlechef, but the purpose of the Vagrantfile tweak is to get Vagrant running chef just like littlechef would be.

Deploy
======

Use littlechef's fix command to deploy to a server.

    # add user / pass for server
    vi config.cfg

    fix node:IPADDRESS deploy_chef
    fix node:IPADDRESS

That should run through the install, and deploy the app.
