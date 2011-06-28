$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'bundler/capistrano'
require 'rvm/capistrano'
set :rvm_ruby_string, '1.9.2@glenwoodbroll'
set :rvm_type, :user

ssh_options[:username] = "passenger"

set :application, "gscra"
set :repository,  "ssh://git@bz-labs.com:2222/home/git/gscra.git"
set :port, 2222
set :scm, :git
set :deploy_to, "/var/www/#{application}"

role :web, "bz-labs.com"
role :app, "bz-labs.com"
role :db,  "bz-labs.com", :primary => true

after "deploy", "deploy:cleanup"
after "deploy", "deploy:migrate"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path, 'tmp', 'restart.txt')}"
  end

  task :migrate do
    run "cd #{release_path}; bundle exec rake RAILS_ENV=production db:migrate"
  end
end

namespace :db do
  desc <<-DESC
    [internal] Updates the symlink for database.yml file to the just deployed release
  DESC
  task :symlink, :except => { :no_release => true } do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "db:symlink"
end

desc "Remote console on the production appserver"
task :console, :roles => :app do
  input = ''
  run "cd #{current_path} && bundle exec rails c production" do |channel, stream, data|
    next if data.chomp == input.chomp || data.chomp == ''
    print data
    channel.send_data(input = $stdin.gets) if data =~ /^(>|\?)>/
  end
end
