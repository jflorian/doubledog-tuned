#
# == Class: tuned
#
# Manages the tuned service on a host.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# This file is part of the doubledog-tuned Puppet module.
# Copyright 2014-2018 John Florian
# SPDX-License-Identifier: GPL-3.0-or-later


class tuned (
        String[1]               $profile,
        Boolean                 $enable,
        Ddolib::Service::Ensure $ensure,
        Array[String[1], 1]     $packages,
        String[1]               $service,
    ) {

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
        '/etc/tuned/profile_mode':
            content => "manual\n",
            ;
    }

    service { $service:
        ensure     => $ensure,
        enable     => $enable,
        hasrestart => true,
        hasstatus  => true,
    }

}
