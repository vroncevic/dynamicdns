dynamicdns
----------

**dynamicdns** is shell tool for control/operating `ddclient <https://help.dyn.com/ddclient/>`_.

Developed in `bash <https://en.wikipedia.org/wiki/Bash_(Unix_shell)>`_ code: **100%**.

|GitHub shell checker|

.. |GitHub shell checker| image:: https://github.com/vroncevic/dynamicdns/workflows/dynamicdns%20shell%20checker/badge.svg
   :target: https://github.com/vroncevic/dynamicdns/actions?query=workflow%3A%22dynamicdns+shell+checker%22

The README is used to introduce the tool and provide instructions on
how to install the tool, any machine dependencies it may have and any
other information that should be provided before the tool is installed.

|GitHub issues| |Documentation Status| |GitHub contributors|

.. |GitHub issues| image:: https://img.shields.io/github/issues/vroncevic/dynamicdns.svg
   :target: https://github.com/vroncevic/dynamicdns/issues

.. |GitHub contributors| image:: https://img.shields.io/github/contributors/vroncevic/dynamicdns.svg
   :target: https://github.com/vroncevic/dynamicdns/graphs/contributors

.. |Documentation Status| image:: https://readthedocs.org/projects/dyn-dns/badge/?version=latest
   :target: https://dyn-dns.readthedocs.io/projects/dyn-dns/en/latest/?badge=latest

.. toctree::
    :hidden:

    self

Installation
-------------

|Debian Linux OS|

.. |Debian Linux OS| image:: https://raw.githubusercontent.com/vroncevic/dynamicdns/dev/docs/debtux.png
   :target: https://www.debian.org

Navigate to release `page`_ download and extract release archive.

.. _page: https://github.com/vroncevic/dynamicdns/releases

To install **dynamicdns** type the following

.. code-block:: bash

   tar xvzf dynamicdns-x.y.tar.gz
   cd dynamicdns-x.y
   cp -R ~/sh_tool/bin/   /root/scripts/dynamicdns/ver.x.y/
   cp -R ~/sh_tool/conf/  /root/scripts/dynamicdns/ver.x.y/
   cp -R ~/sh_tool/log/   /root/scripts/dynamicdns/ver.x.y/

Or You can use Docker to create image/container.

|GitHub docker checker|

.. |GitHub docker checker| image:: https://github.com/vroncevic/dynamicdns/workflows/dynamicdns%20docker%20checker/badge.svg
   :target: https://github.com/vroncevic/dynamicdns/actions?query=workflow%3A%22dynamicdns+docker+checker%22

Dependencies
-------------

**dynamicdns** requires next modules and libraries

* sh_util `https://github.com/vroncevic/sh_util <https://github.com/vroncevic/sh_util>`_

Shell tool structure
---------------------

**dynamicdns** is based on MOP.

Shell tool structure

.. code-block:: bash

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

Copyright and licence
----------------------

|License: GPL v3| |License: Apache 2.0|

.. |License: GPL v3| image:: https://img.shields.io/badge/License-GPLv3-blue.svg
   :target: https://www.gnu.org/licenses/gpl-3.0

.. |License: Apache 2.0| image:: https://img.shields.io/badge/License-Apache%202.0-blue.svg
   :target: https://opensource.org/licenses/Apache-2.0

Copyright (C) 2016 by `vroncevic.github.io/dynamicdns <https://vroncevic.github.io/dynamicdns>`_

**dynamicdns** is free software; you can redistribute it and/or modify it
under the same terms as Bash itself, either Bash version 4.2.47 or,
at your option, any later version of Bash 4 you may have available.

Lets help and support FSF.

|Free Software Foundation|

.. |Free Software Foundation| image:: https://raw.githubusercontent.com/vroncevic/dynamicdns/dev/docs/fsf-logo_1.png
   :target: https://my.fsf.org/

|Donate|

.. |Donate| image:: https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif
   :target: https://my.fsf.org/donate/

Indices and tables
------------------

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`
