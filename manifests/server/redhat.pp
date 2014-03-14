class nfs::server::redhat inherits nfs::client::redhat {

  # TODO if this file change, do we have to reload portmap/rpcbind and rpcsvcgssd also?
  file { '/etc/sysconfig/nfs':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/nfs/redhat.nfsd.conf',
    require => Package['nfs-utils'],
    notify  => Exec['reload_nfs_srv'],
  }

  service {'nfs':
    ensure  => 'running',
    enable  => true,
    pattern => 'nfsd',
  }

  exec {'reload_nfs_srv':
    command     => '/etc/init.d/nfs reload',
    refreshonly => true,
    require     => Package['nfs-utils'],
  }
}

# vim: set expandtab smarttab shiftwidth=2 tabstop=2 softtabstop=2 nocindent noautoindent:
