# Setup New Ubuntu server with nginx
# and add a custom HTTP header

exec { 'update system':
  command => '/usr/bin/apt-get update',
}

package { 'nginx':
  ensure  => 'installed',
  require => Exec['update system'],
}

file { '/var/www/html/index.html':
  ensure  => present,
  content => 'Hello World!',
}

file { '/etc/nginx/sites-available/default':
  ensure  => present,
  notify  => Service['nginx'],
  require => Package['nginx'],
}

exec { 'redirect_me':
  command  => 'sed -i "24i\\	rewrite ^/redirect_me https://th3-gr00t.tk/ permanent;" /etc/nginx/sites-available/default',
  provider => shell,
  require  => File['/etc/nginx/sites-available/default'],
}

exec { 'add_custom_header':
  command  => 'sed -i "25i\	add_header X-Served-By $hostname;" /etc/nginx/sites-available/default',
  provider => shell,
  require  => Exec['redirect_me'],
  notify   => Service['nginx'],
}

service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}
