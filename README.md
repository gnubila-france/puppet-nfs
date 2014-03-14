puppet-nfs
==========

Puppet module for managing NFS.

Based on old version of camptocamp/puppet-nfs module.

# Dependencies

You have to configure your puppetmaster so that exported ressources will work.

# Examples

Client node
```
  node "my-nfs-client" {
    include nfs::client
    nfs::mount {"my mounted one":
      share      => '/srv/nfs/myshare',
      mountpoint => '/mnt/nfs/myshare',
      ensure     => present,
      server     => "nfs.mydomain.ltd",
    }

    nfs::mount {"my unwanted one":
      share      => '/srv/nfs/myshare',
      mountpoint => '/mnt/nfs/myshare',
      ensure     => absent,
      server     => "nfs.mydomain.ltd",
    }
  }
```

Server node
```
  node "my-nfs-server" {
    include nfs::server
    nfs::export { 'NFS export':
      share   => '/mnt/nfs/share',
      options => 'rw,no_root_squash',
      guest   => 'xxx.xxx.xxx.*',
    }
  }
```

# Documentation
http://reductivelabs.com/trac/puppet/wiki/ExportedResources
