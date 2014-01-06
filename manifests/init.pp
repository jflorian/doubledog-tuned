# modules/tuned/manifests/init.pp
#
# == Class: tuned
#
# Configures a host to run tuned for power/performance management.
#
# === Parameters
#
# [*profile*]
#   Profile that tuned is to use.  The default is to automatically select the
#   recommended profile.  See tuned-adm(8) for details.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>


class tuned ($profile=undef) {

    include 'tuned::params'

    package { $tuned::params::packages:
        ensure  => installed,
        notify  => Service[$tuned::params::services],
    }

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0644',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'tuned_rw_etc_t',
        before      => Service[$tuned::params::services],
        notify      => Service[$tuned::params::services],
        subscribe   => Package[$tuned::params::packages],
    }

    if $profile == undef {
        file { '/etc/tuned/active_profile':
        }
    } else {
        file { '/etc/tuned/active_profile':
            content => "$profile",
        }
    }

    service { $tuned::params::services:
        enable      => true,
        ensure      => running,
        hasrestart  => true,
        hasstatus   => true,
    }

}
