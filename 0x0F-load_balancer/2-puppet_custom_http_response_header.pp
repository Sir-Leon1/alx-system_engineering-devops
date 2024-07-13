# Setup New Ubuntu server with nginx
# and custom HTTP header

exec { 'update sys':
	command => '/usr/bin/apt-get update',
}

package { 'nginx':
	ensure => 'installed',
	require => Exec['update sys']
}

file {'/var/www/html/index.html':
	content => 'Hello World!'
}

exec {'redirect_me':
	command => 'sed -i "24i\	rewrite ^/redirect_me http://cuberule.com/ permanent;" /etc/nginx/sites-available/default',
	provider => 'shell'
}

exec {'HTTP head':
	command => 'sed -i "25i\	add_header X-Served-By \$hostname;" /etc/nginx/sites-available/default',
	provider => 'shell'
}

service {'nginx':
	ensure => running,
	require => Package['nginx']
}
