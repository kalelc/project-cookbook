default['app']['puma']['file'] = "config/puma.rb"
default['app']['puma']['folders'] = %w{log sockets pids}
default['app']['puma']['workers'] = 4
default['app']['puma']['threads'] = 16, 32
default['app']['puma']['bind'] = "puma.sock"
default['app']['puma']['pid'] = "puma.pid"
default['app']['puma']['state'] = "puma.state"
default['app']['puma']['logs'] = { access: "puma.access.log", error: "puma.error.log" }
