# == Define: nfs::mount
#
# Configure an NFS mount.
#
# === Authors
#
# Baptiste Grenier <bgrenier@gnubila.fr>
#
# === Copyright
#
# Copyright 2015 gnúbila
#
define nfs::mount (
  $ensure = 'present',
  $server = undef,
  $share = undef,
  $mountpoint = undef,
  $server_options = '',
  $client_options = 'auto',
) {
  validate_string($ensure)
  validate_string($server)
  validate_string($share)
  validate_string($mountpoint)
  validate_string($server_options)
  validate_string($client_options)

  # use exported ressources
  @@nfs::export { "shared ${share} by ${server} for ${::fqdn}":
    ensure  => $ensure,
    share   => $share,
    options => $server_options,
    guest   => $::ipaddress,
    tag     => $server,
  }

  mount { "shared ${share} by ${server}":
    device   => "${server}:${share}",
    fstype   => 'nfs',
    name     => $mountpoint,
    options  => $client_options,
    remounts => false,
    atboot   => true,
  }

  case $ensure {
    'present': {
      exec { "create ${mountpoint} and parents":
        command => "mkdir -p ${mountpoint}",
        unless  => "test -d ${mountpoint}",
      }
      Mount["shared ${share} by ${server}"] {
        ensure  => 'mounted',
        require => [
          Exec["create ${mountpoint} and parents"],
          Class['nfs::client'],
          ],
      }
    }
    'absent': {
      file { $mountpoint:
        ensure  => 'absent',
        require => Mount["shared ${share} by ${server}"],
      }
      Mount["shared ${share} by ${server}"] {
        ensure => 'unmounted',
      }
    }
    default: {
      fail('Unsupported ensure value')
    }
  }
}

# vim: set et sta sw=2 ts=2 sts=2 noci noai:
