require 'bundler/capistrano'

set :application, "pulse_meter_demo"
set :repository,  "git@github.com:savonarola/pulse-meter-demo.git"

set :deploy_via, :copy
set :deploy_to, "/home/av/pulse_meter_demo"
set :user, "av"
set :use_sudo, false

role :app, "rubybox.ru"

after "deploy:restart", "deploy:restart_upstart"

namespace :deploy do
  task :restart_upstart do
    run "sudo restart rubybox-pulse_meter_demo"
  end
end
