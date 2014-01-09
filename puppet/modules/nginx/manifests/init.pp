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
        content => template("nginx/nginx.conf.erb"),
        notify => Service["nginx"],
        require => Package["nginx"],
    }

    file { "/etc/nginx/conf.d/upstream.conf":
        owner  => root,
        group  => root,
        mode   => 644,
        content => template("nginx/upstream.conf.erb"),
        notify => Service["nginx"],
        require => Package["nginx"],
    }

    file { "/etc/nginx/sites-enabled/default":
        ensure => absent,
        notify => Service["nginx"],
        require => Package["nginx"],
    }

    service { "nginx":
        ensure => running,
        hasrestart => true,
        require => Package["nginx"],
    }
}

class nginx::magento-vhost($hostname, $location) {
    file { 'available':
        path => "/etc/nginx/sites-available/magento-vhost",
        owner  => root,
        group  => root,
        mode   => 644,
        content => template("nginx/magento-vhost.conf.erb"),
        notify => Service["nginx"],
        require => Package["nginx"],
    }

    file { 'enabled':
        path => '/etc/nginx/sites-enabled/magento-vhost',
        ensure => 'link',
        target => '/etc/nginx/sites-available/magento-vhost',
        require => File['available'],
        notify => Service["nginx"],
    }
}