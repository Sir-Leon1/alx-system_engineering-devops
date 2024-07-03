# Install specific  version of flask using pip3

node 'flask' {
  python::pip { 'flask':
    ensure       => '2.1.0',
    pip_provider => 'pip3',
  }
}
