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

  $environment = hiera('environment')

  $apache26_dists = hiera('apache26_dists')
  $apache26       = member($apache26_dists, $lsbdistcodename)

  common::add_env{'APPLICATION_ENV':
    key   => 'APPLICATION_ENV',
    value => $environment,
  }

  class {'roles::apache2_server':
    phalcon           => true,
    file_uploads      => 'On',
    file_uploads_size => '10M',
    wsgi              => true
  }

  class{'roles::syslog_sender_server':
    syslog_remote_server => '192.168.33.5'
  }
}
