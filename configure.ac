# This file is processed by autoconf to create a configure script
AC_INIT([async-bus],
        [0.1.0],
        [https://github.com/geoffjay/async-bus],
        [async-bus])

AC_CONFIG_HEADERS([config/config.h])
AC_CONFIG_SRCDIR([src/dev/main.vala])
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_AUX_DIR([config])
AC_PROG_LN_S

m4_ifdef([AM_SILENT_RULES],[AM_SILENT_RULES([yes])])

AC_CANONICAL_TARGET

AM_INIT_AUTOMAKE([1.10 no-define foreign dist-xz no-dist-gzip])
AM_MAINTAINER_MODE([enable])

PKG_PROG_PKG_CONFIG([0.22])

ZMQ_MIN_VERSION=3.3.0

PKG_CHECK_MODULES(ASYNC_BUS, [
    libzmq >= $ZMQ_MIN_VERSION
])

AC_CONFIG_FILES([
    Makefile
    src/Makefile
    src/dev/Makefile
    src/mux/Makefile
])
AC_OUTPUT
