Vagrant Magento
=====

Set-up an Ubuntu host and provision:

* Nginx
* PHP-FPM
* MySQL
* Magento
* With the option of adding the Magento Sample Data as an example application

## Requirements

You'll need:

* [Vagrant][1]
* An [Ubuntu][2] base box for Vagrant (I'm using 12.04)

## Optional sample application

In my Magento Puppet module, I've allowed you to optionally install the Magento
sample application so you can explore the admin interface etc. If you take a
look at [the `base.pp` file in the `puppet` directory][3], you'll see the following
class that instantiates that module:

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

Just set the `use_sample_data` flag to `false` like so:

    use_sample_data => false,

This will now build a vanilla Magento environment.

## Set-up

    $ vagrant up

## Tear-down

    $ vagrant destroy
    $ git clean -dxf

[1]: http://www.vagrantup.com/
[2]: http://www.ubuntu.com/
[3]: puppet/base.pp
