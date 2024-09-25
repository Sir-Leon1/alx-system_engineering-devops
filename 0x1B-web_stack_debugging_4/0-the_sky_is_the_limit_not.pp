# Increase the amount of traffic an Nginx server can handle

# Increase the ULIMIT of the default file
exec {'fix--for-nginx :'
command => 'sed -i "s/15/4096/" /etc/default/nginx',
path => '/usr/local/bin/'
}

exec { 'Edit-nginx-init-script',
command => 
}


# Restart Nginx
-> exec { 'nginx-restart',
command => 'nginx restart',
path => 'etc/init.d/'
}
