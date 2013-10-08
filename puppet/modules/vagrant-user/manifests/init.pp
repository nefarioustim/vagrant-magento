class vagrant-user {
    user { "www-user":
        ensure => present,
        groups => [ "sudo" ]
    }
    user { "vagrant":
        ensure => present,
        groups => [
            "sudo",
            "www-data"
        ]
    }
    file { "/home/vagrant/.bashrc":
        ensure => present,
        owner  => vagrant,
        group  => vagrant,
        mode   => 644,
        source => "puppet:///modules/user/bashrc",
        require => User["vagrant"]
    }
    file { "/home/vagrant/.inputrc":
        ensure => present,
        owner  => vagrant,
        group  => vagrant,
        mode   => 644,
        source => "puppet:///modules/user/inputrc",
        require => User["vagrant"]
    }
    file { "/home/vagrant/.tmux.conf":
        ensure => present,
        owner  => vagrant,
        group  => vagrant,
        mode   => 644,
        source => "puppet:///modules/user/tmux_conf",
        require => User["vagrant"]
    }
    file { "/home/vagrant/.environment":
        ensure => present,
        owner  => vagrant,
        group  => vagrant,
        mode   => 644,
        source => "puppet:///modules/user/environment",
        require => User["vagrant"]
    }
    file { "/home/vagrant/.bash_aliases":
        ensure => present,
        owner  => vagrant,
        group  => vagrant,
        mode   => 644,
        source => "puppet:///modules/user/bash_aliases",
        require => User["vagrant"]
    }
}
