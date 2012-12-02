Chef::Log.info("Configuring local dev sandbox")

# e.g. if the symfony app required composer, ensure it's included
# include_recipe "composer"

# use the application method to deploy (not good for local dev)
# application "symfony-app" do
#     path "/var/www/vhosts/symfony-app"
#     action :deploy
#     # owner "app-user"
#     # group "app-group"
#     repository "git://github.com/streamlinesocial/app-symfony2.git"
#     revision "master"
#     php do
#       migrate true
#       migration_command "script/migration.sh"
#     end
# end

# remove default site
apache_site "default" do
    enable false
end

web_app "sandbox" do
    enable true
    server_name "local.dev"
    server_aliases ["www.local.dev"]
    docroot "/var/www/vhosts"
    directory_options "FollowSymLinks Indexes"
    allow_override "All"
    cookbook "apache2"
end
