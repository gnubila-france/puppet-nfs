class nfs::client {
  case $::osfamily {
    'Debian': { include nfs::client::debian}
    'RedHat': { include nfs::client::redhat}
    default:  { fail "Unsupported OS familly ${::osfamily}" }
  }
}

