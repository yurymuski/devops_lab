#Checking installiation to do
#based on custom servercheck fact
class exittask::todolist ($package_serv_v = 'latest' ) {
  if $::servercheck == 'true' {
    notice ( "Hostname is ${::hostname}, be_server? ${::servercheck}" )
    package{'puppetlabs-release-pc1-1.1.0-2.el7.noarch':
      ensure   => 'installed',
      provider => 'rpm',
      source   => 'https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm',
      }
    package { 'puppetserver':
      ensure  => $package_serv_v,
      require => Package['puppetlabs-release-pc1-1.1.0-2.el7.noarch'],
      }
    exec { 'reloadprofile':
      command  => 'source /etc/profile',
      require  => Package['puppetserver'],
      provider => shell,
      }
    file { '/etc/puppetlabs/puppet/autosign.conf':
      content => template('/vagrant/exittask/templates/autosign.erb'),
      owner   => root,
      group   => root,
      mode    => '0644'
      }
    service { 'puppetserver':
      ensure  => 'running',
      require =>  [ Exec['reloadprofile'], File['/etc/puppetlabs/puppet/autosign.conf'] ],
      }
  }
  else {
    notice ( "Hostname is ${::hostname}, be_server? ${::servercheck}")
    package{'puppetlabs-release-pc1-1.1.0-2.el7.noarch':
      ensure   => 'installed',
      provider => 'rpm',
      source   => 'https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm',
      }
    package { 'puppet-agent':
      ensure  => 'latest',
      require => Package['puppetlabs-release-pc1-1.1.0-2.el7.noarch'],
      }
    service { 'puppet':
      ensure  => 'running',
      require => Host['puppet'],
      }
    host { 'puppet':
      host_aliases =>  'puppet.local',
      ip           => '192.168.25.150',
      }
  }
}
