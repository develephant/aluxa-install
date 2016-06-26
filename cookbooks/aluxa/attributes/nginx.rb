###############################################################################
# NGINX
###############################################################################
default['nginx']['user']          = 'aluxa'
default['nginx']['lua_path']      = '/usr/local/aluxa/lualib/?.lua;/usr/local/aluxa/skills/?.lua;;'
default['nginx']['lua_cache']     = 'off'

###############################################################################
# Development certs
###############################################################################
default['nginx']['ssl_cert']    = '/etc/ssh/aluxa.crt'
default['nginx']['ssl_key']     = '/etc/ssh/aluxa.key'

###############################################################################
# Logging
###############################################################################
default['nginx']['log_dir']       = '/home/aluxa/logs'
default['nginx']['log_file']      = '/home/aluxa/logs/aluxa.log'
default['nginx']['log_level']     = 'notice'

###############################################################################
# Misc
###############################################################################
default['nginx']['bin']           = '/usr/local/aluxa/nginx/sbin/nginx'
default['nginx']['conf']          = '/usr/local/aluxa/nginx/conf'
