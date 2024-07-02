# Create a file in /tmp
file { 'school':
  ensure  => 'present',
  content => 'I love Puppet',
  mode    => '0744',
  owner   => 'www-data',
  group   => 'www-data',
  path    => '/tmp/school'
}
