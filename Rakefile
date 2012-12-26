#!/usr/bin/env ruby
#^syntax detection

require 'rubygems'

# directory "dir1"
# something like the following would be required to trigger the dir1 create task though
# task :init => ["dir1", "init:cookbooks"] do
directory "site-cookbooks"
directory "cookbooks"
directory "ssh-keys"

file 'config.cfg' => ['littlechef:init'] do
    puts "config.cfg created (for littlechef)"
end

# @TODO: Test to ensure this runs in windows cmd
task :default do
    sh "rake -T"
end

# Load all tasks defined in lib/tasks/*.rake
# Dir[File.expand_path("lib/tasks/", __FILE__) + '/*.rake'].each do |file|
#   load file
# end

# desc "updates cookbooks and other things that would need to be updated"
# task :update => ['cookbook:update'] do
#     # default task is to list them
# end

namespace 'init' do
    desc "inits folders and gems for building cookbooks"
    task :devel => ['setup:devel', 'site-cookbooks', 'cookbooks', 'cookbook:update']

    desc "inits folders and initial deployment"
    task :deploy => ['init:devel', 'setup:deploy', 'config.cfg']

    # default init namespace to devel
    task :all => ['devel', 'deploy']
end

# default for init namespace
task :init => 'init:devel'

namespace 'deploy' do
    desc "deploy local dev server"
    task :devel do
        Rake::Task['littlechef:deploy'].invoke('local.dev')
    end

    # desc "deploy staging server"
    # task "stage" do
    #     Rake::Task['littlechef:deploy'].invoke('local.strsocial.com')
    # end
end

namespace 'setup' do
    desc 'install deps'
    task :devel do
        puts "Warning: sudo may be required"
        sh "gem install vagrant --no-ri --no-rdoc"
        sh "gem install librarian --no-ri --no-rdoc"
        sh "vagrant gem install vagrant-hostmaster --no-ri --no-rdoc"
    end

    desc 'install deps for deploy'
    task :deploy do
        puts "Warning: sudo may be required"
        sh "sudo pip install --upgrade git+https://github.com/tobami/littlechef.git"
        sh "gem install foodcritic --no-ri --no-rdoc"
    end

    # set setup default to devel
    task :all => ['devel', 'deploy']
end

# default for setup namespace
task :setup => 'setup:devel'

namespace :cookbook do
    # see https://github.com/applicationsonline/librarian-chef
    desc 'update cookbooks using librarian-chef Cheffile'
    task :update do
        sh 'librarian-chef update'
    end

    desc 'install cookbooks using librarian-chef Cheffile.lock'
    task :update do
        sh 'librarian-chef install'
    end
end

# default for cookbook namespace
task :cookbook => 'cookbook:install'

namespace :littlechef do
    desc "runs the 'fix new_kitchen' command to init the kitchen"
    task :init do
        sh "fix new_kitchen"
    end

    desc "deploys a node per the args given"
    task :deploy, ['node'] do |t,args|
        node = args["node"]
        sh "fix node:#{node}"
    end

    task :all => ['init']
end

namespace 'generate' do
    desc 'make ssh keys for deploy'
    task 'sshkeygen' => ['ssh-keys'] do
        sh "ssh-keygen -f ssh-keys/deploy.rsa -t rsa -N '' -C deploy-key"
    end
end

namespace :vm do
    desc 'boot up the virtual machine'
    task :up do
        sh 'vagrant up'
    end

    desc 'check the status of the virtual machine'
    task :status do
        sh 'vagrant status'
    end

    desc 'shutdown virtual machine'
    task :halt do
        sh 'vagrant halt'
    end

    desc 'delete virtual machine'
    task :destroy do
        sh 'vagrant destroy'
    end

    desc 'boot the virtual machine but ignore chef provision scripts'
    task :justboot do
        sh 'vagrant up --no-provision'
    end

    desc 're-provision the virtual machine'
    task :provision do
        sh 'vagrant provision'
    end

    desc 'suspend the box, leaving the state along with its hold on the port/ip in tact (frees memory/cpu resources on host)'
    task :suspend do
        sh 'vagrant suspend'
    end

    desc 'resume suspended box'
    task :resume do
        sh 'vagrant resume'
    end
end

task :vm => ['vm:status']
