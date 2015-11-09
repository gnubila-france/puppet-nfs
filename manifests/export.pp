# == Define: nfs::export
#
# Configure an NFS export.
define nfs::export (
  $ensure = 'present',
  $options = '',
  $share = undef,
  $guest = undef,
) {
  validate_string($ensure)
  validate_string($options)
  validate_string($share)
  validate_string($guest)

  $concatshare = regsubst($share, '/', '-', 'G')
  $concatguest = regsubst($guest, '/','-', 'G')

  if $options == '' {
    $content = "${share}     ${guest}\n"
  } else {
    $content = "${share}     ${guest}(${options})\n"
  }

  Concat <| title == '/etc/exports' |>

  concat::fragment {"share-${concatshare}-on-${concatguest}":
    ensure  => $ensure,
    content => $content,
    target  => '/etc/exports',
    notify  => Exec['reload_nfs_srv'],
  }
}

# vim: set et sta sw=2 ts=2 sts=2 noci noai:
