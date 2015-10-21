# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
# Don't declare `role :all`, it's a meta role
current_branch = `git branch`.match(/\* (\S+)\s/m)[1]
set :branch, ENV['branch'] || 'master'
role :app, %w(roruser@192.168.0.202)
role :web, %w(roruser@192.168.0.202)
role :db,  %w(roruser@192.168.0.202)

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.
# server 'frdatalayer.netsolutions.in', user: 'roruser', roles: %w(web app)
server '192.168.0.202', user: 'roruser', roles: %w(web app)
set :enable_ssl, false

# you can set custom ssh options
# it's possible to pass any option but you need to keep in mind that net/ssh understand limited list of options
# you can see them in [net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start)
# set it globally
set :ssh_options, {
  keys: %w(~/.ssh/id_rsa),
  forward_agent: true,
  #auth_methods: %w(password)
}
# and/or per server
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
# setting per server overrides global ssh_options
