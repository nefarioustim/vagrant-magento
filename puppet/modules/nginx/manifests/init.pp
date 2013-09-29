class nginx {
    package { [
            "nginx",
        ]:
        ensure => latest,
    }

    file { "/etc/nginx/nginx.conf":
        owner  => root,
        group  => root,
        mode   => 644,
        source => "puppet:///modules/nginx/nginx.conf",
        notify => Service["nginx"],
        require => Package["nginx"],
    }

    file { "/etc/nginx/conf.d/upstream.conf":
        owner  => root,
        group  => root,
        mode   => 644,
        source => "puppet:///modules/nginx/upstream.conf",
        notify => Service["nginx"],
        require => Package["nginx"],
    }

    file { "/etc/nginx/sites-enabled/default":
        ensure => absent,
        notify => Service["nginx"],
        require => Package["nginx"],
    }

    file { 'available':
        path => '/etc/nginx/sites-available/magentolols',
        ensure => 'link',
        target => '/var/www/magentolols/etc/dev.nginx.conf',
    }

    file { 'enabled':
        path => '/etc/nginx/sites-enabled/magentolols',
        ensure => 'link',
        target => '/etc/nginx/sites-available/magentolols',
        require => File['available'],
        notify => Service["nginx"],
    }

    service { "nginx":
        ensure => running,
        hasrestart => true,
        require => Package["nginx"],
    }
}