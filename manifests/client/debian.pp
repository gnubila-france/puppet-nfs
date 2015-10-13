class nfs::client::debian {
  package { 'nfs-common':
    ensure => 'present',
  }
  package { 'portmap':
    ensure => 'present',
  }

  service { 'nfs-common':
    ensure    => 'running',
    enable    => true,
    hasstatus => true,
    require   => Package['nfs-common'],
  }
  service { 'portmap':
    ensure    => 'running',
    enable    => true,
    hasstatus => false,
    require   => Package['portmap'],
  }
}

# vim: set et sta sw=2 ts=2 sts=2 noci noai:
