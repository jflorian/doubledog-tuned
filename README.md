<!---
Copyright 2018 John Florian <jflorian@doubledog.org>
SPDX-License-Identifier: GPL-3.0-or-later

This file is part of the doubledog-tuned Puppet module.

doubledog-tuned is free software; you can redistribute it and/or modify it
under the terms of the GNU Lesser General Public License as published by the
Free Software Foundation; either version 3.0 of the License, or (at your
option) any later version.
-->
# tuned

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with tuned](#setup)
    * [What tuned affects](#what-tuned-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with tuned](#beginning-with-tuned)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
    * [Classes](#classes)
    * [Defined types](#defined-types)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This module lets you manage `tuned`, the dynamic adaptive system tuning daemon.

## Setup

### What tuned Affects

### Setup Requirements

### Beginning with tuned

## Usage

## Reference

**Classes:**

* [tuned](#tuned-class)

**Defined types:**

* [tuned::profile](#tunedprofile-defined-type)


### Classes

#### tuned class

This class manages the `tuned` daemon.

##### `profile` (required)
Name of the profile that `tuned` is to activate.  Run `sudo tuned-adm list` to see a list of available profile names as well as the currently active one.  See tuned-adm(8) for details.

##### `enable`
Instance is to be started at boot.  Either `true` (default) or `false`.

##### `ensure`
Instance is to be `running` (default) or `stopped`.  Alternatively, a Boolean value may also be used with `true` equivalent to `running` and `false` equivalent to `stopped`.

##### `packages`
An array of package names needed for the `tuned` installation.  The default should be correct for supported platforms.

##### `profiles`
A hash whose keys are profile resource names and whose values are hashes comprising the same parameters you would otherwise pass to the [tuned::profile](#tunedprofile-defined-type) defined type.

##### `service`
The service name of the `tuned` daemon.  The default should be correct for supported platforms.


### Defined types

#### tuned::profile defined type

This defined type lets you manage custom tuned profiles.

##### `namevar` (REQUIRED)
The name of the profile.

##### `ensure`
Instance is to be `present` (default) or `absent`.  Alternatively, a Boolean value may also be used with `true` equivalent to `present` and `false` equivalent to `absent`.

##### `content`
Literal content for the profile file.  One and only one of `content` or `source` must be given.

##### `source`
URI of the profile file content.  One and only one of `content` or `source` must be given.


## Limitations

Tested on modern Fedora and CentOS releases, but likely to work on any Red Hat variant.  Adaptations for other operating systems should be trivial as this module follows the data-in-module paradigm.  See `data/common.yaml` for the most likely obstructions.  If "one size can't fit all", the value should be moved from `data/common.yaml` to `data/os/%{facts.os.name}.yaml` instead.  See `hiera.yaml` for how this is handled.

This should be compatible with Puppet 3.x and is being used with Puppet 4.x as well.

## Development

Contributions are welcome via pull requests.  All code should generally be compliant with puppet-lint.
