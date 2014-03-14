class nfs::server::debian inherits nfs::client::debian {

  # XXX is it needed to reboot for updating the loaded module options?
  file { '/etc/modprobe.d/local.conf':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/nfs/debian.local.conf',
    notify  => Service['nfs-common'],
  }
  file { '/etc/default/nfs-common':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/nfs/debian.nfs-common',
    notify  => Service['nfs-common'],
  }
  file { '/etc/default/nfs-kernel-server':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/nfs/debian.nfs-kernel-server',
    notify  => Exec['reload_nfs_srv'],
  }
  
  package {'nfs-kernel-server':
    ensure  => 'present',
  }

  service {'nfs-kernel-server':
    enable  => 'true',
    pattern => 'nfsd',
    require => Package['nfs-kernel-server'],
  }
  
  exec {'reload_nfs_srv':
    command     => "/etc/init.d/nfs-kernel-server reload",
    refreshonly => true,
    require     => Package['nfs-kernel-server'],
  }
}

# vim: set expandtab smarttab shiftwidth=2 tabstop=2 softtabstop=2 nocindent noautoindent:
