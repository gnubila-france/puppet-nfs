class nfs::server::redhat {
  include ::nfs::client::redhat

  # TODO if this file change, do we have to reload portmap/rpcbind and rpcsvcgssd also?
  file { '/etc/sysconfig/nfs':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => "puppet:///modules/nfs/redhat-${::lsbmajdistrelease}.nfsd.conf",
    require => Package['nfs-utils'],
    notify  => Exec['reload_nfs_srv'],
  }

  service { 'nfs':
    ensure  => 'running',
    enable  => true,
    pattern => 'nfsd',
  }

  exec { 'reload_nfs_srv':
    command     => '/etc/init.d/nfs reload',
    refreshonly => true,
    require     => Package['nfs-utils'],
  }

  @concat { '/etc/exports':
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    notify => Exec['reload_nfs_srv'],
  }
}

# vim: set et sta sw=2 ts=2 sts=2 noci noai:
