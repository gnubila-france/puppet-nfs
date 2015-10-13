class nfs::server::debian {
  include ::nfs::client::debian

  # XXX is it needed to reboot for updating the loaded module options?
  file { '/etc/modprobe.d/local.conf':
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/nfs/debian.local.conf',
    notify => Service['nfs-common'],
  }
  file { '/etc/default/nfs-common':
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/nfs/debian.nfs-common',
    notify => Service['nfs-common'],
  }
  file { '/etc/default/nfs-kernel-server':
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/nfs/debian.nfs-kernel-server',
    notify => Exec['reload_nfs_srv'],
  }

  package { 'nfs-kernel-server':
    ensure => 'present',
  }

  service { 'nfs-kernel-server':
    enable  => true,
    pattern => 'nfsd',
    require => Package['nfs-kernel-server'],
  }

  exec { 'reload_nfs_srv':
    command     => '/etc/init.d/nfs-kernel-server reload',
    refreshonly => true,
    require     => Package['nfs-kernel-server'],
  }
}

# vim: set et sta sw=2 ts=2 sts=2 noci noai:
