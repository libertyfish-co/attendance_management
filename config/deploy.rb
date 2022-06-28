# config valid for current version and patch releases of Capistrano
lock "~> 3.17.0"

set :application, "attendance_management"
set :repo_url, "git@github.com:libertyfish-co/attendance_management.git"

set :deploy_to, '/var/www/rails/attendance_management'

# 以下、日報サイトと同様
set :scm, :git
set :branch, 'master'
set :log_level, :info
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/uploads}
set :bundle_binstubs, nil
set :keep_releases, 5

set :unicorn_rack_env, 'production'
set :unicorn_options, '-p 5000'

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
    desc 'Restart application'
    task :restart do
        invoke 'unicorn:legacy_restart'
    end
end
