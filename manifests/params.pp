# modules/tuned/manifests/params.pp
#
# == Class: tuned::params
#
# Parameters for the tuned puppet module.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>


class tuned::params {

    case $::operatingsystem {

        Fedora: {
            $packages = [
                'tuned',
            ]
            $services = [
                'tuned',
            ]

        }

        default: {
            fail ("The tuned module is not yet supported on $::operatingsystem.")
        }

    }

}
