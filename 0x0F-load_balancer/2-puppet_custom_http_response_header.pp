# Automate the task of creating a custom HTTP header response with Puppet

exec { 'update_system':
  command => '/usr/bin/apt-get update',
  path    => ['/usr/bin', '/usr/sbin'],
}

package { 'nginx':
  ensure  => 'installed',
  require => Exec['update_system'],
}

file { '/etc/nginx/sites-available/default':
  ensure  => present,
  content => template('module_name/nginx_config.erb'),
  require => Package['nginx'],
  notify  => Service['nginx'],
}

service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}

# Define a custom template to insert the X-Served-By header into the Nginx configuration
file { '/etc/puppetlabs/code/modules/module_name/templates/nginx_config.erb':
  ensure  => present,
  content => "# Nginx configuration with X-Served-By header\nserver {\n    listen 80 default_server;\n    listen [::]:80 default_server;\n    root /var/www/html;\n    index index.html index.htm index.nginx-debian.html;\n    server_name _;\n    add_header X-Served-By ${hostname};\n    location / {\n        try_files \$uri \$uri/ =404;\n    }\n    if (\$request_filename ~ redirect_me){\n        rewrite ^ https://th3-gr00t.tk/ permanent;\n    }\n    error_page 404 /error_404.html;\n    location = /error_404.html {\n        internal;\n    }\n}",
}
