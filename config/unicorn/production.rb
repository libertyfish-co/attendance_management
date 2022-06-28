# アプリケーション名
application = 'attendance_management'

app_path = '/var/www/rails/#{application}/current'

# ワーカー数
worker_processes 4

# ダウンタイムなしでデプロイ可能に
preload_app true

# ログのパス指定
stderr_path "#{app_path}/log/unicorn.stderr.log"
stdout_path "#{app_path}/log/unicorn.stdout.log"

# listen
listen "#{app_path}/tmp/sockets/unicorn.sock"

# pid
pid "#{app_path}/tmp/pids/unicorn.pid"

before_fork do |server, worker|
	defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!

  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
  sleep 1
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end