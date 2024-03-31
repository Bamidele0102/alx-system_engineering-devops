# Setup New Ubuntu server with nginx,
# and add a custom HTTP header

# Run apt-get update
exec {'update':
  command  => '/usr/bin/apt-get -y update',
  provider => shell,
  path     => ['/usr/bin', '/usr/sbin'],
  before   => Exec['install Nginx'],
}

# Install Nginx
exec {'install Nginx':
  command  => '/usr/bin/apt-get -y install nginx',
  provider => shell,
  path     => ['/usr/bin', '/usr/sbin'],
  require  => Exec['update'],
  before   => Exec['add_header'],
}

# Add custom HTTP header
file { '/etc/nginx/conf.d/custom_header.conf':
  ensure  => present,
  content => "add_header X-Served-By ${hostname};",
  notify  => Exec['restart Nginx'],
}

# Restart Nginx
service { 'nginx':
  ensure    => running,
  enable    => true,
  subscribe => File['/etc/nginx/conf.d/custom_header.conf'],
}
