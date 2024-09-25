# Increase the ULIMIT of the default file
exec { 'fix-for-nginx':
  command => 'sed -i "s/15/4096/" /etc/default/nginx',
  path    => ['/usr/local/bin', '/bin', '/usr/bin'],
}

# Restart Nginx
exec { 'nginx-restart':
  command => '/etc/init.d/nginx restart',
  path    => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  require => Exec['fix-for-nginx'],  # Ensure this runs after the fix
}

