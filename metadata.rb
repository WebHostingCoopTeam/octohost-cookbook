# encoding: utf-8
name             'octohost'
maintainer       'Darron Froese'
maintainer_email 'darron@froese.org'
license          'Apache 2.0'
description      'Installs/configures octohost'
version          '1.0.2'
recipe           'octohost::default', 'Installs/configures octohost'

depends 'chef-sugar'
depends 'apt'
depends 'ark'
depends 'ubuntu_base'
depends 'octobase'
depends 'docker'
depends 'openresty'
depends 'gitreceive'
depends 'sysdig'
depends 'consul'
depends 'firewall'
depends 'ruby2'
depends 'logrotate'
depends 'rsyslog'
