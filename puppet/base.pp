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
        before => Package["build-essential"]
    }
    group { "puppet":
        ensure => present,
    }
    package { "build-essential":
        ensure => latest,
        before => Package["vim"],
    }
    package { [
            "tmux",
            "vim",
            "git",
            "git-flow",
            "aptitude"
        ]:
        ensure => latest,
    }
    package { "memcached":
        ensure => latest
    }
}

class { "devbox": stage => pre }

include php
include nginx
