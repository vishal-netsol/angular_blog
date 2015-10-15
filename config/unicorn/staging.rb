# Set the working application directory
# working_directory "/path/to/your/app"
root = '/var/www/angular_blog/current'
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn_stderr.log"
stdout_path "#{root}/log/unicorn_stdout.log"
listen '/tmp/unicorn.angular_blog.sock'
listen 8600
worker_processes 2
timeout 360
