dnl This file is processed by autoconf to create a configure script
AC_INIT([opendcs],
        [0.1.0],
        [https://github.com/geoffjay/opendcs],
        [opendcs])

AC_CONFIG_HEADERS([config.h])
AC_CONFIG_SRCDIR([src/dev/main.vala])
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_AUX_DIR([build-aux])

AC_PROG_CC
AM_PROG_CC_STDC
AM_PROG_VALAC([0.22.0])
AC_PROG_LN_S

m4_ifdef([AM_SILENT_RULES],[AM_SILENT_RULES([yes])])

AC_CANONICAL_TARGET

AM_INIT_AUTOMAKE([1.10 no-define foreign dist-xz no-dist-gzip])
AM_MAINTAINER_MODE([enable])

PKG_PROG_PKG_CONFIG([0.22])

dnl No rhyme or reason here, just the versions that I'm working with
COMEDI_MIN_VERSION=0.8.1
CURSES_MIN_VERSION=5.9.0
GEE_MIN_VERSION=0.8.0
GIO_MIN_VERSION=2.39.3
ZMQ_MIN_VERSION=3.2.0

PKG_CHECK_MODULES(DCS, [
    comedi      >= $COMEDI_MIN_VERSION
    ncurses     >= $CURSES_MIN_VERSION
    gee-0.8     >= $GEE_MIN_VERSION
    gio-2.0     >= $GIO_MIN_VERSION
    libzmq      >= $ZMQ_MIN_VERSION
])

dnl Check if the user wants to build the HMI component
AC_ARG_WITH(hmi,
  AS_HELP_STRING([--without-hmi],[Do not build HMI applications]),
  try_hmi=$withval, try_hmi=yes )

HAVE_GTK=no
if test x$try_hmi = xyes ; then
    dnl Check for gtk
    PKG_CHECK_MODULES([DCS_HMI_DEPS], [gtk+-3.0 >= $GTK_REQUIRED],
      [
        DCS_CHECK_PACKAGES([gtk+-3.0], [HAVE_GTK=yes])
        DCS_HMI_DEPS_VALAFLAGS="VALAFLAGS --pkg gtk+-3.0"
        AC_SUBST([DCS_HMI_DEPS_VALAFLAGS])
      ],
      [
        AC_MSG_WARN([HMI dependencies not found.])
        AC_MSG_WARN([HMI applications will not be built.])
      ])
else
    AC_MSG_NOTICE([HMI applications disabled.])
fi

AM_CONDITIONAL(BUILD_HMI, test "x$HAVE_GTK" = "xyes")

AC_CONFIG_FILES([
    Makefile
    src/Makefile
    src/dev/Makefile
    src/hmi/Makefile
    src/mux/Makefile
    src/top/Makefile
    test/Makefile
])

AC_OUTPUT

AC_MSG_NOTICE([

    OpenDCS $VERSION
    ================================

    Prefix:             ${prefix}
    Source location:    ${srcdir}
    Compiler:           ${CC}
    CFLAGS:             ${CFLAGS}
    VALAFLAGS:          ${VALAFLAGS}

    > Component Selection

    HMI:                ${HAVE_GTK}
    API Documentation:  ${found_valadoc}

    > Configure Complete

    Now type 'make' to build $PACKAGE
])
