# Puppet manifest to config ssh client

# Add configuration to use the specified private key
file_line { 'Declare identity file':
  ensure => present,
  line   => '   IdentityFile ~/.ssh/school',
  match  => '^IdentityFile',
  path   => '~/.ssh/config',
}

# Add configuration to refuse password authentication
file_linr { 'Turn off passwd auth':
  ensure => present,
  line   => '   PasswordAuthentication no',
  match  => '^PasswordAuthentication',
  path   => '~/.ssh/config',
}

# Ensure Host ubuntu@98.98.98.98 present before adding lines
file_line { 'Ensure Host entry':
  ensure => present,
  line   => 'Host ubuntu@98.98.98.98',
  match  => '^Host',
  path   => '~/.ssh/config',
}