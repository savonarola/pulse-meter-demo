set :application, "pulse_meter_demo"
set :repository,  "git@github.com:savonarola/pulse-meter-demo.git"

set :deploy_via, :copy
set :deploy_to, "/home/av/pulse_meter_demo"

role :app, "rubybox.ru"

