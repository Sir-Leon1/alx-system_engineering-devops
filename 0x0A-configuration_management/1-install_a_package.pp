# Install specific  version of flask using pip3

package { 'python3-pip':
ensure   => installed,
}

exec { 'install-flask':
command => '/bin/pip3 install Flask==2.1.0',
creates => '/usr/local/lib/python3.8/dist-packages/flask/__init__.py',
require => Package['python3-pip'],
path => ['/usr/bin', '/usr/local/bin'],
}
