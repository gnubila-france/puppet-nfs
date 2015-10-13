class nfs::client {
  case $::osfamily {
    'Debian': { include ::nfs::client::debian}
    'RedHat': { include ::nfs::client::redhat}
    default:  { fail "Unsupported OS familly ${::osfamily}" }
  }
}

# vim: set et sta sw=2 ts=2 sts=2 noci noai:
