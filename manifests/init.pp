#
# == Class: tuned
#
# Manages the tuned service on a host.
#
# === Parameters
#
# ==== Required
#
# [*profile*]
#   Profile that tuned is to use.  Run "sudo tuned-adm list" to see a list of
#   available profile names as well as the currently active one.  See
#   tuned-adm(8) for details.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2014-2018 John Florian


class tuned (
        $profile,
        Boolean                                         $enable,
        Variant[Boolean, Enum['running', 'stopped']]    $ensure,
        Array[String[1], 1]                             $packages,
        String[1]                                       $service,
    ) {

    validate_re(
        $profile, '^.+$',
        "${title}: 'profile' must be a non-null string"
    )

    package { $packages:
        ensure => installed,
        notify => Service[$service],
    }

    file {
        default:
            owner     => 'root',
            group     => 'root',
            mode      => '0644',
            seluser   => 'system_u',
            selrole   => 'object_r',
            seltype   => 'tuned_rw_etc_t',
            before    => Service[$service],
            notify    => Service[$service],
            subscribe => Package[$packages],
            ;
        '/etc/tuned/active_profile':
            content => "${profile}\n",
            ;
    }

    service { $service:
        ensure     => $ensure,
        enable     => $enable,
        hasrestart => true,
        hasstatus  => true,
    }

}
