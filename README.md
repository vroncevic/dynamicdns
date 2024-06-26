# Dynamic DNS

<img align="right" src="https://raw.githubusercontent.com/vroncevic/dynamicdns/dev/docs/dynamicdns_logo.png" width="25%">

**dynamicdns** is shell tool for control/operating **[ddclient](https://help.dyn.com/ddclient/)**.

Developed in **[bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell))** code: **100%**.

[![dynamicdns_shell_checker](https://github.com/vroncevic/dynamicdns/actions/workflows/dynamicdns_shell_checker.yml/badge.svg)](https://github.com/vroncevic/dynamicdns/actions/workflows/dynamicdns_shell_checker.yml)

The README is used to introduce the tool and provide instructions on
how to install the tool, any machine dependencies it may have and any
other information that should be provided before the tool is installed.

[![GitHub issues open](https://img.shields.io/github/issues/vroncevic/dynamicdns.svg)](https://github.com/vroncevic/dynamicdns/issues) [![GitHub contributors](https://img.shields.io/github/contributors/vroncevic/dynamicdns.svg)](https://github.com/vroncevic/dynamicdns/graphs/contributors)

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**

- [Installation](#installation)
- [Usage](#usage)
- [Dependencies](#dependencies)
- [Shell tool structure](#shell-tool-structure)
- [Docs](#docs)
- [Copyright and licence](#copyright-and-licence)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

### Installation

![Debian Linux OS](https://raw.githubusercontent.com/vroncevic/dynamicdns/dev/docs/debtux.png)

Navigate to release **[page](https://github.com/vroncevic/dynamicdns/releases)** download and extract release archive.

To install **dynamicdns** type the following

```bash
tar xvzf dynamicdns-x.y.tar.gz
cd dynamicdns-x.y
cp -R ~/sh_tool/bin/   /root/scripts/dynamicdns/ver.x.y/
cp -R ~/sh_tool/conf/  /root/scripts/dynamicdns/ver.x.y/
cp -R ~/sh_tool/log/   /root/scripts/dynamicdns/ver.x.y/
```

Self generated setup script and execution

```bash
./dynamicdns_setup.sh 

[setup] installing App/Tool/Script dynamicdns
	Mon 22 Nov 2021 12:41:00 AM CET
[setup] clean up App/Tool/Script structure
[setup] copy App/Tool/Script structure
[setup] remove github editor configuration files
[setup] set App/Tool/Script permission
[setup] create symbolic link of App/Tool/Script
[setup] done

/root/scripts/dynamicdns/ver.2.0/
├── bin/
│   ├── center.sh
│   ├── display_logo.sh
│   └── dynamicdns.sh
├── conf/
│   ├── dynamicdns.cfg
│   ├── dynamicdns.logo
│   └── dynamicdns_util.cfg
└── log/
    └── dynamicdns.log

3 directories, 7 files
lrwxrwxrwx 1 root root 50 Nov 22 00:41 /root/bin/dynamicdns -> /root/scripts/dynamicdns/ver.2.0/bin/dynamicdns.sh
```

Or You can use docker to create image/container.

### Usage

```bash
# Create symlink for shell tool
ln -s /root/scripts/dynamicdns/ver.x.y/bin/dynamicdns.sh /root/bin/dynamicdns

# Setting PATH
export PATH=${PATH}:/root/bin/

# Start dynamic dns client
dynamicdns
```

### Dependencies

**dynamicdns** requires next modules and libraries
* sh_util [https://github.com/vroncevic/sh_util](https://github.com/vroncevic/sh_util)

### Shell tool structure

**dynamicdns** is based on MOP.

Shell tool structure

```bash
sh_tool/
├── bin/
│   ├── center.sh
│   ├── display_logo.sh
│   └── dynamicdns.sh
├── conf/
│   ├── dynamicdns.cfg
│   ├── dynamicdns.logo
│   └── dynamicdns_util.cfg
└── log/
    └── dynamicdns.log
```

### Docs

[![Documentation Status](https://readthedocs.org/projects/dyn-dns/badge/?version=latest)](https://dyn-dns.readthedocs.io/projects/dyn-dns/en/latest/?badge=latest)

More documentation and info at
* [https://dyn-dns.readthedocs.io/en/latest/](https://dyn-dns.readthedocs.io/en/latest/)
* [https://www.gnu.org/software/bash/manual/](https://www.gnu.org/software/bash/manual/)
* [https://manpages.debian.org/stretch/ddclient](https://manpages.debian.org/stretch/ddclient/ddclient.8.en.html)

### Copyright and licence

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Copyright (C) 2016 - 2024 by [vroncevic.github.io/dynamicdns](https://vroncevic.github.io/dynamicdns)

**dynamicdns** is free software; you can redistribute it and/or modify
it under the same terms as Bash itself, either Bash version 4.2.47 or,
at your option, any later version of Bash 4 you may have available.

Lets help and support FSF.

[![Free Software Foundation](https://raw.githubusercontent.com/vroncevic/dynamicdns/dev/docs/fsf-logo_1.png)](https://my.fsf.org/)

[![Donate](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://my.fsf.org/donate/)
