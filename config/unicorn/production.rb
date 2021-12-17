$worker  = 2
$timeout = 30
$app_dir = "/var/www/chapthread/current"
$listen  = File.expand_path 'tmp/sockets/unicorn.sock', $app_dir
$pid     = File.expand_path 'tmp/pids/unicorn.pid', $app_dir
$std_log = File.expand_path 'log/unicorn.log', $app_dir
worker_processes  $worker
working_directory $app_dir
stderr_path $std_log
stdout_path $std_log
timeout $timeout
listen  $listen
pid $pid
preload_app true
before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      Process.kill "QUIT", File.read(old_pid).to_i
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end
after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
[Unit]
Description=unicorn cheapthread service
After=network.target

[Service]
User=ubuntu
Environment=RAILS_ENV=production
WorkingDirectory=/var/www/cheapthread/current
PIDFile=/var/www/cheapthread/current/tmp/pids/unicorn.pid
ExecStart=/usr/local/rbenv/shims/bundle exec unicorn -c /var/www/cheapthread/current/config/unicorn/production.rb -D
Restart=always

[Install]
WantedBy=multi-user.target