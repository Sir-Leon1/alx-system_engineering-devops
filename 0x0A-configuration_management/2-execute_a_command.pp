# Kill a process named killmenow

#Define process to be killed
$process_name = 'killmenow'

exec { "kill ${process_name}":
  command => "pkill -f ${process_name}",
  path    => ['/bin', '/usr/bin', '/usr/sbin'],
  onlyif  => "pgrep -f ${process_name}",
}