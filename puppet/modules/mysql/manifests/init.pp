class mysql ( $root_password ) {
    package { "mysql-server": ensure => latest }
    package { "mysql-client": ensure => latest }
    package { "php5-mysql": ensure => latest }

    file { "/etc/mysql/my.cnf":
        content => template("mysql/my.cnf.erb")
    }

    exec { "set-root-password":
        subscribe => [ Package["mysql-server"], Package["mysql-client"] ],
        refreshonly => true,
        unless => "mysqladmin -uroot -p${root_password} status",
        path => "/bin:/usr/bin",
        command => "mysqladmin -uroot password ${root_password}",
    }

    exec { "create-vagrant-user-all":
      unless => "mysqladmin -uvagrant -pvagrant status",
      path => "/bin:/usr/bin",
      command => "mysql -uroot -p${root_password} -e \"CREATE USER vagrant@'%' IDENTIFIED BY 'vagrant'; GRANT ALL ON *.* TO vagrant@'%' WITH GRANT OPTION;\"",
      require => Service["mysql"],
    }

    exec { "create-vagrant-user-localhost":
      unless => "mysqladmin -uvagrant -pvagrant status",
      path => "/bin:/usr/bin",
      command => "mysql -uroot -p${root_password} -e \"CREATE USER vagrant@'localhost' IDENTIFIED BY 'vagrant'; GRANT ALL ON *.* TO vagrant@'localhost' WITH GRANT OPTION;\"",
      require => Service["mysql"],
    }

    service { "mysql":
        require => [ Package["mysql-server"], Exec["set-root-password"] ],
        hasstatus => true,
    }
}
