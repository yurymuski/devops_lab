node default {
   include '::ntp'
}

node puppet2.local {
 class { '::mysql::server':
    root_password    => 'Pa$$w0rd',
  }
  mysql_database { 'test_db':
      ensure  => present,
      charset => 'utf8',
  }
  mysql_user { 'test_user@localhost':
    ensure => present,
  }
  mysql_grant { 'test_user@localhost/test_db.*':
    ensure	=> present,
    options     => ['GRANT'],
    privileges  => ['ALL'],
    table	=> 'test_db.*',
    user        => 'test_user@localhost',
  }
}

