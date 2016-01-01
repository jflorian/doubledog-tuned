# modules/tuned/manifests/init.pp
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
# ==== Optional
#
# [*ensure*]
#   Service is to be 'running' (default) or 'stopped'.
#
# [*enable*]
#   Service is to be started at boot; either true (default) or false.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2014-2016 John Florian


class tuned (
        $profile,
        $enable=true,
        $ensure='running',
    ) inherits ::tuned::params {

    validate_re(
        $profile, '^.+$',
        "${title}: 'profile' must be a non-null string"
    )

    package { $::tuned::params::packages:
        ensure => installed,
        notify => Service[$::tuned::params::services],
    }

    File {
        owner     => 'root',
        group     => 'root',
        mode      => '0644',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'tuned_rw_etc_t',
        before    => Service[$::tuned::params::services],
        notify    => Service[$::tuned::params::services],
        subscribe => Package[$::tuned::params::packages],
    }

    file { '/etc/tuned/active_profile':
        content => "${profile}\n",
    }

    service { $::tuned::params::services:
        ensure     => $ensure,
        enable     => $enable,
        hasrestart => true,
        hasstatus  => true,
    }

}
