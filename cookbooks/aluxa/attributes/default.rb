###############################################################################
# Build & Deploy
###############################################################################
default['deploy']['letsencrypt']  = true # [true=letsencrypt|false=selfsigned]
default['deploy']['ssl_only']     = true # force ssl port 443 only
###############################################################################
default['aluxa']['host']          = 'aluxa.coronium.cloud'
default['aluxa']['email']         = 'no-reply@coronium.cloud'
###############################################################################
# GENERAL
###############################################################################
default['aluxa']['user']          = 'aluxa'
default['aluxa']['group']         = 'aluxa'
###############################################################################
default['aluxa']['password']      = '$1$SmKi8o0C$gvUV4isRupzSycD/hXWI5.'
###############################################################################
# DEVELOPER
###############################################################################
default['aluxa']['root']          = '/home/aluxa'
default['aluxa']['skills']        = '/home/aluxa/skills'
default['aluxa']['lib']           = '/usr/local/aluxa/lualib/aluxa'
default['aluxa']['bin']           = '/usr/local/bin/aluxa'
default['aluxa']['templates']     = '/usr/local/aluxa/alexa_skill'
default['aluxa']['repo']          = 'https://github.com/develephant/aluxa-deploy.git'
