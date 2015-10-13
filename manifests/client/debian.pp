class nfs::client::debian {
  package { 'nfs-common':
    ensure => 'present',
  }
  package { 'portmap':
    ensure => 'present',
  }
 
  service { 'nfs-common':
    ensure    => 'running',
    enable    => 'true',
    hasstatus => 'true',
    require   => Package['nfs-common'],
  }
  service { 'portmap':
    ensure    => 'running',
    enable    => 'true',
    hasstatus => 'false',
    require   => Package['portmap'],
  }
}

# vim: set expandtab smarttab shiftwidth=2 tabstop=2 softtabstop=2 nocindent noautoindent:
