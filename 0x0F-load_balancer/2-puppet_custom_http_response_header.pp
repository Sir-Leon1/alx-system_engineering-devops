#nginx setup

#Ensure Nginx package is installed and service is running
package { 'nginx':
  ensure => installed,
}

service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}

# Define directory and file resources for HTML content
file { '/etc/nginx/html':
  ensure => directory,
}

file { '/etc/nginx/html/index.html':
  ensure  => file,
  content => 'Hello World!',
}

file { '/etc/nginx/html/404.html':
  ensure  => file,
  content => "Ceci n'est pas une page",
}

#Nginx server configuration
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => @(END),
server {
  listen  80 default_server;
  listen  [::]:80 default_server;
  root    /etc/nginx/html;
  index   index.html;

  location /redirect_me {
    return 301 http://cuberule.com;
  }

  error_page 404 /404.html;
  location /404 {
    root /etc/nginx/html;
    internal;
  }
  
  location / {
    add_header X-Served-By "$HOSTNAME";
  }
}
END
notify    => Service['nginx'],
}
