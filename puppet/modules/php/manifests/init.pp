class php {
    package { [
            "php5-fpm",
        ]:
        ensure => latest,
    }
}