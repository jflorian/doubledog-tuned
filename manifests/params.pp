# modules/tuned/manifests/params.pp
#
# == Class: tuned::params
#
# Parameters for the tuned puppet module.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2014-2015 John Florian


class tuned::params {

    case $::operatingsystem {
        Fedora: {
            $packages = 'tuned'
            $services = 'tuned'

        }

        default: {
            fail ("${title}: operating system '${::operatingsystem}' is not supported")
        }

    }

}
