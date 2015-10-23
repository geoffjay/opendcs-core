# OpenDCS Core - Core components to create distributed control systems

* Until the OpenDCS account on GitHub becomes free...

 - Bugs: https://github.com/geoffjay/opendcs-core/issues
 - Download: https://github.com/geoffjay/opendcs-core/releases
 - Git: https://github.com/geoffjay/opendcs-core
 - Website: http://geoffjay.github.io/opendcs
 - IRC: <TBD>

---

This portion of OpenDCS can be built from tarball releases using the traditional
autotools manner.

If you checked the code out from git, you will need to bootstrap the build
system like so:

  ./autogen.sh

Then, a typical build might look like so:

  ./configure --prefix=/usr
  make
  sudo make install

---

OpenDCS and all it's components are licensed under the GNU Lesser General Public
License as published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
