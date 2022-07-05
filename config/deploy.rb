# config valid for current version and patch releases of Capistrano
lock "~> 3.17.0"

set :application, "attendance_management"
set :repo_url, "git@github.com:libertyfish-co/attendance_management.git"

server '49.212.167.121', port: 2025, roles: [:app, :web, :db], primary: true

# user
set :user, 'attendance_management'
set :user_sudo, false

# server
set :stage, :production
set :deploy_via, :remote_cache
set :deploy_to, "/var/www/rails/#{fetch(:application)}"

# terminal
set :pty, true

# ssh
set :ssh_options,{
	user: 'deploy'
}

# environment
set :linked_dirs, fetch(:linked_dirs, []).push(
  'log',
  'tmp/pids',
  'tmp/cache',
  'tmp/sockets',
  'vendor/bundle',
  'public/system',
  'public/uploads'
)

set :linked_files, fetch(:linked_files, []).push(
  'config/database.yml',
  'config/secrets.yml',
  'lib/tasks/config/env.yml'
)

set  :local_path, `pwd`.chomp

set :log_level, :info
set :keep_releases, 5
set :branch, 'master'

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

	desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  desc 'Upload database.yml and secrets.yml'
  task :upload do
    on roles(:app) do |host|
      if test "[ ! -d #{shared_path}/config ]"
        execute "mkdir -p #{shared_path}/config"
      end
      upload!('config/database.yml', "#{shared_path}/config/database.yml")
      upload!('config/secrets.yml', "#{shared_path}/config/secrets.yml")
    end
  end

  before :starting,     :upload
  before :starting,     'exam:upload'
  before :starting,     :check_revision
end

# unicorn:日報サイトと同様
set :unicorn_rack_env, 'production'
set :unicorn_options, '-p 5000'

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
    desc 'Restart application'
    task :restart do
        invoke 'unicorn:legacy_restart'
    end
end
