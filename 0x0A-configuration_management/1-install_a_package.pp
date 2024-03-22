# Using Puppet, install_flask.pp from pip3
# Ensure Python3 and pip3 are installed

package { 'python3-pip':
  ensure => present,
}

exec { 'install_flask':
  command => '/usr/bin/pip3 install Flask==2.1.0',
  path    => ['/usr/bin'],
  require => Package['python3-pip'],
}

exec { 'install_werkzeug':
  command => '/usr/bin/pip3 install Werkzeug==2.1.1',
  path    => ['/usr/bin'],
  require => Package['python3-pip'],
}
