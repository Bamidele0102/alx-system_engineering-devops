# Setup New Ubuntu server with nginx

# Update system package index
exec { 'update_system':
  command => '/usr/bin/apt-get update',
}

# Install Nginx package
package { 'nginx':
  ensure  => 'installed',
  require => Exec['update_system'],
}

# Create HTML file with 'Hello World!' content
file { '/var/www/html/index.html':
  ensure  => file,
  content => 'Hello World!',
}

# Add redirection rule to Nginx configuration
exec { 'redirect_me':
  command  => 'sed -i "24i\\rewrite ^/redirect_me https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;" /etc/nginx/sites-available/default',
  provider => 'shell',
}

# Ensure Nginx service is running
service { 'nginx':
  ensure  => running,
  require => Package['nginx'],
}
