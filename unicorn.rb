APP_PATH = "/Users/sergeyaveryanov/git/pulse-meter-demo"
CURRENT = File.join(APP_PATH, '')
SHARED = File.join(APP_PATH, 'shared')

worker_processes 5
preload_app false
timeout 30

working_directory CURRENT
listen 3000
#listen "#{CURRENT}/tmp/unicorn.sock", :backlog => 2048  

PID = "#{SHARED}/pids/unicorn.pid"
pid PID
stderr_path "#{SHARED}/log/unicorn.log"
stdout_path "#{SHARED}/log/unicorn.log"

