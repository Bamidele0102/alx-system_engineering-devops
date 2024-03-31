# Setup New Ubuntu server with nginx
# and add a custom HTTP header

exec { 'update_and_install_nginx':
  command     => '/usr/bin/apt-get update -y -qq && /usr/bin/apt-get install -y nginx -qq',
  unless      => '/usr/bin/dpkg -l | /bin/grep nginx',
}

file { '/etc/ufw/applications.d/Nginx':
  ensure  => present,
  content => "Nginx HTTP\n",
}

service { 'ufw':
  ensure => running,
  enable => true,
}

file { '/var/www/html/index.html':
  ensure  => present,
  content => 'Hello World!',
}

file { '/var/www/html/error_404.html':
  ensure  => present,
  content => "Ceci n'est pas une page",
}

file { '/etc/nginx/sites-enabled/default':
  ensure  => present,
  content => "server {
                listen 80 default_server;
                listen [::]:80 default_server;
                root /var/www/html;
                index index.html index.htm index.nginx-debian.html;
                server_name _;
                add_header X-Served-By $hostname;
                location / {
                    try_files \$uri \$uri/ =404;
                }
                if (\$request_filename ~ redirect_me){
                    rewrite ^ https://th3-gr00t.tk/ permanent;
                }
                error_page 404 /error_404.html;
                location = /error_404.html {
                    internal;
                }
            }",
  notify  => Service['nginx'],
}

service { 'nginx':
  ensure  => running,
  enable  => true,
}
