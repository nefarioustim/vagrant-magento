class mysql {
    package { "mysql-server":
        ensure => latest
    }
    package { "php5-mysql":
        ensure => latest
    }
}