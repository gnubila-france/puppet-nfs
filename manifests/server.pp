class nfs::server {
  firewall { '050 allow UDP rpcbind port':
    proto  => 'udp',
    dport  => '111',
    action => 'accept',
  }
  firewall { '050 allow TCP rpcbind port':
    dport  => '111',
    action => 'accept',
  }
  firewall { '050 allow TCP NFS port':
    dport  => '2049',
    action => 'accept',
  }
  firewall { '050 allow TCP LOCKD_TCPPORT port':
    dport  => '32803',
    action => 'accept',
  }
  firewall { '050 allow TCP callback port':
    dport  => '32764',
    action => 'accept',
  }
  firewall { '050 allow UDP LOCKD_UDPPORT port':
    proto  => 'udp',
    dport  => '32769',
    action => 'accept',
  }
  firewall { '050 allow UDP MOUNTD_PORT port':
    proto  => 'udp',
    dport  => '892',
    action => 'accept',
  }
  firewall { '050 allow TCP MOUNTD_PORT port':
    dport  => '892',
    action => 'accept',
  }
  firewall { '050 allow UDP RQUOTAD_PORT port':
    proto  => 'udp',
    dport  => '875',
    action => 'accept',
  }
  firewall { '050 allow TCP RQUOTAD_PORT port':
    dport  => '875',
    action => 'accept',
  }
  firewall { '050 allow UDP STATD_PORT port':
    proto  => 'udp',
    dport  => '662',
    action => 'accept',
  }
  firewall { '050 allow TCP STATD_PORT port':
    dport  => '662',
    action => 'accept',
  }

  case $::osfamily {
    'Debian': { include nfs::server::debian}
    'RedHat': { include nfs::server::redhat}
    default:  { fail "Unsupported OS familly ${::osfamily}" }
  }
}

# vim: set et sta sw=2 ts=2 sts=2 noci noai:
