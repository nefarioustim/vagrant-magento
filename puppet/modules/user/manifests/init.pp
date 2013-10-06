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
        source => "puppet:///modules/user/bashrc",
        require => User["huegdon"]
    }
    file { "/home/huegdon/.inputrc":
        ensure => present,
        owner  => huegdon,
        group  => huegdon,
        mode   => 644,
        source => "puppet:///modules/user/inputrc",
        require => User["huegdon"]
    }
    file { "/home/huegdon/.tmux.conf":
        ensure => present,
        owner  => huegdon,
        group  => huegdon,
        mode   => 644,
        source => "puppet:///modules/user/tmux_conf",
        require => User["huegdon"]
    }
    file { "/home/huegdon/.environment":
        ensure => present,
        owner  => huegdon,
        group  => huegdon,
        mode   => 644,
        source => "puppet:///modules/user/environment",
        require => User["huegdon"]
    }
    file { "/home/huegdon/.bash_aliases":
        ensure => present,
        owner  => huegdon,
        group  => huegdon,
        mode   => 644,
        source => "puppet:///modules/user/bash_aliases",
        require => User["huegdon"]
    }
}
