###############################################################################
# Aluxa CORE
###############################################################################
default['core']['root']     = '/usr/local/aluxa'
default['core']['lib']      = '/usr/local/aluxa/lualib'
default['core']['skills']   = '/usr/local/aluxa/skills'
default['core']['certs']    = '/usr/local/aluxa/certs'
###############################################################################
# Aluxa install bundle (vagrant host)
###############################################################################
default['core']['src']      = "aluxa-core.tar.gz"
default['core']['dest']     = "/usr/local/aluxa-core.tar.gz"
default['core']['tar']      = "aluxa-core.tar.gz"
###############################################################################
# Aluxa bundle remote src (non-vagrant host)
###############################################################################
default['core']['src_url']  = "https://s3.amazonaws.com/coronium-aluxa/aluxa-core.tar.gz"
