#
# == Define: tuned::profile
#
# Manages a custom tuned profile on a host.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# This file is part of the doubledog-tuned Puppet module.
# Copyright 2018 John Florian
# SPDX-License-Identifier: GPL-3.0-or-later


define tuned::profile (
        Ddolib::File::Ensure    $ensure='present',
        Optional[String]        $content=undef,
        Optional[String]        $source=undef,
    ) {

    include 'tuned'

    file {
        default:
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
            seluser => 'system_u',
            selrole => 'object_r',
            seltype => 'tuned_etc_t',
            ;
        "/etc/tuned/${name}":
            ensure  => directory,
            ;
        "/etc/tuned/${name}/tuned.conf":
            ensure  => $ensure,
            content => $content,
            source  => $source,
            notify  => Service[$tuned::service],
            ;
    }

}
