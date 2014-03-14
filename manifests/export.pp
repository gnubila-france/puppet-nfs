define nfs::export ($ensure=present,
                    $share,
                    $options='',
                    $guest) {

  $concatshare = substitute($share, '/', '-')
  $concatguest_tmp = substitute($guest, '/','-')
  $concatguest_tmp2 = substitute($concatguest_tmp, '\[','_OSB_')
  $concatguest = substitute($concatguest_tmp2, '\]','_CSB_')

  if ($options == '') {
    $content = "${share}     ${guest}\n"
  } else {
    $content = "${share}     ${guest}($options)\n"
  }

  common::concatfilepart {"share-${concatshare}-on-${concatguest}":
    ensure  => $ensure,
    content => $content,
    file    => '/etc/exports',
    notify  => Exec['reload_nfs_srv'],
  }
}

# vim: set expandtab smarttab shiftwidth=2 tabstop=2 softtabstop=2 nocindent noautoindent:
