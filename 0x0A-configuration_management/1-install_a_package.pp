# Install specific  version of flask using pip3

# Install Flask version
package { 'Flask':
  ensure   => '2.1.0',
  provider => 'pip3',
}

# Install pip for python 3
package { 'python3-pip':
  ensure  => 'installed',
}

# Install Werkzeug 2.1.1 using pip
package { 'Werkzeug':
  ensure   => '2.1.1',
  provider => 'pip3',
}
