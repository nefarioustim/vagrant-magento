class ondrejppa {
    include apt

    apt::pparepo { "ondrej/php5":
        apt_key => "E5267A6C",
        ensure => present
    }
}

class php {
    require ondrejppa

    package { [
            "php5-fpm",
            "php5-cli",
            "php-pear",
            "php5-mcrypt",
            "php5-curl",
            "php5-gd",
        ]:
        ensure => latest,
        require => Class['ondrejppa'],
    }

    file { "/etc/php5/fpm/php.ini":
        content => template("php/php.ini.erb"),
        notify => Service["php5-fpm"],
        require => Package["php5-fpm"]
    }

    # file { "/var/lib/php5/session":
    #     ensure => "directory",
    #     owner  => "root",
    #     group  => "root",
    #     mode   => 777,
    # }

    # file { "/etc/php5/fpm/pool.d/www.conf":
    #     content => template("php/www.conf.erb"),
    #     notify => Service["php5-fpm"],
    #     require => [
    #         Package["php5-fpm"],
    #         File["/var/lib/php5/session"]
    #     ]
    # }

    service { "php5-fpm":
        ensure => running,
        hasrestart => true,
        require => Package["php5-fpm"],
    }
}

class php::composer {
    exec { "getcomposer":
        command => "curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer",
        user => "root",
        creates => "/usr/local/bin/composer",
        require => [
            Class["php"],
            Package["curl"]
        ],
    }
}
