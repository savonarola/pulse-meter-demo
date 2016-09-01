APP_PATH = "/home/av/pulse-meter.rubybox.ru"
CURRENT = APP_PATH
SHARED = APP_PATH

worker_processes 5
preload_app false
timeout 30

working_directory CURRENT
listen "#{CURRENT}/run/unicorn.sock", :backlog => 2048

PID = "#{SHARED}/run/unicorn.pid"
pid PID
stderr_path "#{SHARED}/log/unicorn.log"
stdout_path "#{SHARED}/log/unicorn.log"

