# Setup New Ubuntu server with nginx
# and add a custom HTTP header

exec { 'update system':
  command => '/usr/bin/apt-get update',
}

package { 'nginx':
  ensure  => 'installed',
  require => Exec['update system'],
}

file { '/var/www/html':
  ensure => directory,
}

file { '/var/www/html/index.html':
  ensure  => present,
  content => 'Hello World!',
}

file { '/etc/nginx/sites-available/default':
  ensure  => present,
  content => template('module_name/default.erb'),
  notify  => Service['nginx'],
  require => Package['nginx'],
}

service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}
