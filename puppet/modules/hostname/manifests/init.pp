define hostname($hostname = $title) {
    $host_alias = regsubst($name, '^([^.]*).*$', '\1')

    host { "newhost":
        ensure => present,
        ip     => $ipaddress,
        name  => $hostname,
        host_aliases  => $host_alias ? {
            $hostname => undef,
            default     => $host_alias,
        },
        notify => Service['hostname'],
    }

    file { '/etc/mailname':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => 644,
        content => "${hostname}\n",
    }

    file { '/etc/hostname':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => 644,
        content => "${hostname}\n",
        notify => Service['hostname'],
    }

    service { "hostname":
        ensure => running,
        hasrestart => true
    }
}
