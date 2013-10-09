class user {
    user { "huegdon":
        ensure => present,
        groups => [ "sudo" ]
    }
    user { "www-user":
        ensure => present,
        groups => [ "sudo" ]
    }
    file { "/home/huegdon/.bashrc":
        ensure => present,
        owner  => huegdon,
        group  => huegdon,
        mode   => 644,
        content => template("user/bashrc.erb"),
        require => User["huegdon"]
    }
    file { "/home/huegdon/.inputrc":
        ensure => present,
        owner  => huegdon,
        group  => huegdon,
        mode   => 644,
        content => template("user/inputrc.erb"),
        require => User["huegdon"]
    }
    file { "/home/huegdon/.tmux.conf":
        ensure => present,
        owner  => huegdon,
        group  => huegdon,
        mode   => 644,
        content => template("user/tmux.conf.erb"),
        require => User["huegdon"]
    }
    file { "/home/huegdon/.environment":
        ensure => present,
        owner  => huegdon,
        group  => huegdon,
        mode   => 644,
        content => template("user/environment.erb"),
        require => User["huegdon"]
    }
    file { "/home/huegdon/.bash_aliases":
        ensure => present,
        owner  => huegdon,
        group  => huegdon,
        mode   => 644,
        content => template("user/bash_aliases.erb"),
        require => User["huegdon"]
    }
}
