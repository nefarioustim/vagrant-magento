if $virtual == 'virtualbox' {
    $userandgroup = 'vagrant'
}

$project_name = "vagrant-magento"
$project_root = "/home/${userandgroup}/${project_name}"
$project_host = "magento.nefariousdesigns.co.uk"

stage { "pre": before => Stage["main"] }

Exec {
    path => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin'
}

class devbox {
    hostname { "update-hostname":
        hostname => $project_host
    }
    exec { "aptupdate":
        command => "aptitude update --quiet --assume-yes",
        user => "root",
        timeout => 0,
    }
    group { "puppet":
        ensure => present,
    }
    package { "build-essential":
        ensure => latest,
    }
    package { [
            "python-software-properties",
            "tmux",
            "vim",
            "curl",
            "git",
            "git-flow",
            "aptitude",
            "memcached",
        ]:
        ensure => latest,
        require => Exec["aptupdate"]
    }
}

class { "devbox": stage => pre }

class { "user":
    stage => pre,
    username => $userandgroup,
    groupname => $userandgroup
}

include nginx
class { "nginx::magento-vhost":
    hostname => $project_host,
    location => $project_root
}

class { "mysql": root_password => "monkeys" }

class { "php": db_binding => "mysql" }
include php::composer

class { "magento":
    /* magento version */
    version => "1.8.0.0",

    /* magento database settings */
    db_username => "magento",
    db_password => "magento",

    /* magento admin user */
    admin_username => "admin",
    admin_password => "123123abc",

    /* "yes" or "no" */
    use_rewrites => "yes",

    /* true or false */
    use_sample_data => true,
}
