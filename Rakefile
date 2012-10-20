#!/usr/bin/env ruby
#^syntax detection

# directory "dir1"
# something like the following would be required to trigger the dir1 create task though
# task :init => ["dir1", "init:cookbooks"] do
directory "site-cookbooks"
directory "cookbooks"
directory "ssh-keys"

file 'auth.cfg' => ['littlechef:init'] do
    puts "auth.cfg created"
end

# files need to be used before they are triggered
file 'Cheffile' do
    FileUtils.cp 'scripts/misc/Cheffile.example', 'Cheffile'
    puts "Copied Cheffile.example to Cheffile"
end

# @TODO: Test to ensure this runs in windows cmd
task 'default'do
    sh "rake -T"
end

# Load all tasks defined in lib/tasks/*.rake
# Dir[File.expand_path("lib/tasks/", __FILE__) + '/*.rake'].each do |file|
#   load file
# end

desc "inits folders and initial deployment of the cookbooks"
task "init"=> ['site-cookbooks', 'cookbooks', 'auth.cfg', 'librarian:update'] do
    # default task is to list them
end

desc "updates cookbooks and other things that would need to be updated"
task "update" => ['librarian:update'] do
    # default task is to list them
end

namespace 'deploy' do
    desc "deploy local dev server"
    task "dev" do
        Rake::Task['littlechef:deploy'].invoke('jpef.dev')
    end

    desc "deploy staging server"
    task "stage" do
        Rake::Task['littlechef:deploy'].invoke('jpef.strsocial.com')
    end
end

desc 'install deps'
task 'install_deps' do
    puts "Warning: sudo may be required"
    sh "gem install librarian --no-ri --no-rdoc"
    sh "sudo pip install --upgrade git+https://github.com/tobami/littlechef.git"
    sh "gem install foodcritic --no-ri --no-rdoc"
    sh "vagrant gem install vagrant-hostmaster --no-ri --no-rdoc"
end

namespace 'librarian' do
    # see https://github.com/applicationsonline/librarian-chef
    desc "install cookbooks using librarian-chef"
    task "update" do
        # sh "librarian-chef update --verbose"
        sh "librarian-chef update"
    end
end

namespace 'littlechef' do
    desc "runs the 'fix new_kitchen' command to init the kitchen"
    task "init" do
        sh "fix new_kitchen"
    end

    desc "deploys a node per the args given"
    task "deploy", ["node"] do |t,args|
        node = args["node"]
        sh "fix node:#{node}"
    end
end

namespace 'generate' do
    desc 'make ssh keys for deploy'
    task 'sshkeygen'  => ['ssh-keys'] do
        sh "ssh-keygen -f ssh-keys/deploy.rsa -t rsa -N ''"
    end
end
