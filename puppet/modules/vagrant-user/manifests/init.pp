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
        content => template("user/bashrc.erb"),
        require => User["vagrant"]
    }
    file { "/home/vagrant/.inputrc":
        ensure => present,
        owner  => vagrant,
        group  => vagrant,
        mode   => 644,
        content => template("user/inputrc.erb"),
        require => User["vagrant"]
    }
    file { "/home/vagrant/.tmux.conf":
        ensure => present,
        owner  => vagrant,
        group  => vagrant,
        mode   => 644,
        content => template("user/tmux.conf.erb"),
        require => User["vagrant"]
    }
    file { "/home/vagrant/.environment":
        ensure => present,
        owner  => vagrant,
        group  => vagrant,
        mode   => 644,
        content => template("user/environment.erb"),
        require => User["vagrant"]
    }
    file { "/home/vagrant/.bash_aliases":
        ensure => present,
        owner  => vagrant,
        group  => vagrant,
        mode   => 644,
        content => template("user/bash_aliases.erb"),
        require => User["vagrant"]
    }
}
