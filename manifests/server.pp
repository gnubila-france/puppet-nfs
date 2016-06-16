# == Class: nfs::server
#
# Role for installing a NFS Server
#
# one of the 2 parameters must be set
#
# === Parameters
#
# [*client_ips*]
#   client IP or list of client IPs séparated by ',' .
#   Default: undef
#
# [*client_ips_range*]
#   range of client IPs.
#   Default: undef
#
# === Examples
#
#  include '::nfs::server'
#
# Configuration is done using Hiera.
#
#
class nfs::server (
  $client_ips = undef,
  $client_ips_range = undef,
)
{

  if $client_ips == undef and $client_ips_range == undef {
    fail('One of client_ips or client_ips_range should be provided!')
  }
  if $client_ips != undef and $client_ips_range != undef {
    fail('Only one of client_ip and client_ips_range should be provided!')
  }

  if $client_ips != undef {
    firewall { '050 allow UDP rpcbind port':
      source => $client_ips,
      proto  => 'udp',
      dport  => '111',
      action => 'accept',
    }
    firewall { '050 allow TCP rpcbind port':
      source => $client_ips,
      dport  => '111',
      action => 'accept',
    }
    firewall { '050 allow TCP NFS port':
      source => $client_ips,
      dport  => '2049',
      action => 'accept',
    }
    firewall { '050 allow TCP LOCKD_TCPPORT port':
      source => $client_ips,
      dport  => '32803',
      action => 'accept',
    }
    firewall { '050 allow TCP callback port':
      source => $client_ips,
      dport  => '32764',
      action => 'accept',
    }
    firewall { '050 allow UDP LOCKD_UDPPORT port':
      source => $client_ips,
      proto  => 'udp',
      dport  => '32769',
      action => 'accept',
    }
    firewall { '050 allow UDP MOUNTD_PORT port':
      source => $client_ips,
      proto  => 'udp',
      dport  => '892',
      action => 'accept',
    }
    firewall { '050 allow TCP MOUNTD_PORT port':
      source => $client_ips,
      dport  => '892',
      action => 'accept',
    }
    firewall { '050 allow UDP RQUOTAD_PORT port':
      source => $client_ips,
      proto  => 'udp',
      dport  => '875',
      action => 'accept',
    }
    firewall { '050 allow TCP RQUOTAD_PORT port':
      source => $client_ips,
      dport  => '875',
      action => 'accept',
    }
    firewall { '050 allow UDP STATD_PORT port':
      source => $client_ips,
      proto  => 'udp',
      dport  => '662',
      action => 'accept',
    }
    firewall { '050 allow TCP STATD_PORT port':
      source => $client_ips,
      dport  => '662',
      action => 'accept',
    }
  } else {
    firewall { '050 allow UDP rpcbind port':
      src_range => $client_ips_range,
      proto  => 'udp',
      dport  => '111',
      action => 'accept',
    }
    firewall { '050 allow TCP rpcbind port':
      src_range => $client_ips_range,
      dport  => '111',
      action => 'accept',
    }
    firewall { '050 allow TCP NFS port':
      src_range => $client_ips_range,
      dport  => '2049',
      action => 'accept',
    }
    firewall { '050 allow TCP LOCKD_TCPPORT port':
      src_range => $client_ips_range,
      dport  => '32803',
      action => 'accept',
    }
    firewall { '050 allow TCP callback port':
      src_range => $client_ips_range,
      dport  => '32764',
      action => 'accept',
    }
    firewall { '050 allow UDP LOCKD_UDPPORT port':
      src_range => $client_ips_range,
      proto  => 'udp',
      dport  => '32769',
      action => 'accept',
    }
    firewall { '050 allow UDP MOUNTD_PORT port':
      src_range => $client_ips_range,
      proto  => 'udp',
      dport  => '892',
      action => 'accept',
    }
    firewall { '050 allow TCP MOUNTD_PORT port':
      src_range => $client_ips_range,
      dport  => '892',
      action => 'accept',
    }
    firewall { '050 allow UDP RQUOTAD_PORT port':
      src_range => $client_ips_range,
      proto  => 'udp',
      dport  => '875',
      action => 'accept',
    }
    firewall { '050 allow TCP RQUOTAD_PORT port':
      src_range => $client_ips_range,
      dport  => '875',
      action => 'accept',
    }
    firewall { '050 allow UDP STATD_PORT port':
      src_range => $client_ips_range,
      proto  => 'udp',
      dport  => '662',
      action => 'accept',
    }
    firewall { '050 allow TCP STATD_PORT port':
      src_range => $client_ips_range,
      dport  => '662',
      action => 'accept',
    }    
  }
  case $::osfamily {
    'Debian': { include ::nfs::server::debian }
    'RedHat': { include ::nfs::server::redhat }
    default:  { fail "Unsupported OS familly ${::osfamily}" }
  }
}

# vim: set et sta sw=2 ts=2 sts=2 noci noai:
