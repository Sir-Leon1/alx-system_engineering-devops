# Puppet manifest to config ssh client

# Add configuration to use the specified private key
file_line { 'Declare identity file':
  ensure => present,
  line   => '   IdentityFile ~/.ssh/school',
  match  => '^IdentityFile',
  path   => '/etc/ssh/ssh_config',
}

# Add configuration to refuse password authentication
file_line { 'Turn off passwd auth':
  ensure => present,
  line   => '   PasswordAuthentication no',
  match  => '^PasswordAuthentication',
  path   => '/etc/ssh/ssh_config',
}

# Ensure Host ubuntu@98.98.98.98 present before adding lines
file_line { 'Ensure Host entry':
  ensure => present,
  line   => 'Host ubuntu@98.98.98.98',
  match  => '^Host',
  path   => '/etc/ssh/ssh_config',
}

