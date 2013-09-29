stage { "pre": before => Stage["main"] }

Exec {
    path => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin'
}

class devbox {
    rename { "magento.nefariousdesigns.co.uk": }
    exec { "aptupdate":
        command => "aptitude update --quiet --assume-yes",
        user => "root",
        timeout => 0,
    }
    group { "puppet":
        ensure => present,
    }
    package { "build-essential":
        ensure => latest,
    }
    package { [
            "python-software-properties",
            "tmux",
            "vim",
            "curl",
            "git",
            "git-flow",
            "aptitude",
            "memcached",
        ]:
        ensure => latest,
        require => Exec["aptupdate"]
    }
}

class { "devbox": stage => pre }

include php
include php::composer
include nginx
