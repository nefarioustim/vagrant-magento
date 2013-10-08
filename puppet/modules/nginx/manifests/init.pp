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
        path => '/etc/nginx/sites-available/vagrant-magento',
        ensure => 'link',
        target => '/var/www/vagrant-magento/etc/dev.nginx.conf',
    }

    file { 'enabled':
        path => '/etc/nginx/sites-enabled/vagrant-magento',
        ensure => 'link',
        target => '/etc/nginx/sites-available/vagrant-magento',
        require => File['available'],
        notify => Service["nginx"],
    }

    service { "nginx":
        ensure => running,
        hasrestart => true,
        require => Package["nginx"],
    }
}