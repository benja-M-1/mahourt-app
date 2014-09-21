# Capifony documentation: http://capifony.org
# Capistrano documentation: https://github.com/capistrano/capistrano/wiki

# Be more verbose by uncommenting the following line
logger.level = Logger::MAX_LEVEL

# Must be set for the password prompt from git to work
default_run_options[:pty] = true

set :domain,      "54.194.156.115"
set :application, "mahourt-app"
set :deploy_to,   "/var/www/mahourt-app"
set :user,        "www-data"
ssh_options[:forward_agent] = true

role :web, domain
role :app, domain, :primary => true
role :db,  domain, :primary => true

set :scm,         :git
set :repository,  "git@github.com:benja-M-1/mahourt-app"
set :branch,      "master"
set :deploy_via,  :remote_cache

set :use_composer,   true
set :update_vendors, true

set :dump_assetic_assets, true

set :writable_dirs,     ["app/cache", "app/logs"]
set :webserver_user,    "www-data"
set :permission_method, :acl

set :shared_files,    ["app/config/parameters.yml", "web/.htaccess", "web/robots.txt"]
set :shared_children, ["app/logs"]

set :model_manager, "doctrine"

set :use_sudo,    false

set :keep_releases, 3

after "deploy:update", "deploy:cleanup"
after "deploy", "deploy:set_permissions"