stage{'pre':}
stage{'post':}

Stage[pre] -> Stage[main] -> Stage[post]

node default {

  class {'common::vagrant':
    stage => pre
  }

  common::set_localtime{'set_localtime':
    zone => 'Europe/Madrid'
  }

  file {'backup_dir':
    ensure => directory,
    path   => $backup_dir,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  class {'roles::mongodb_server':

  class {'roles::kyototycoon_server':
    memcached => true
  }
}

