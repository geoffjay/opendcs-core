dnl This file is processed by autoconf to create a configure script
AC_INIT([opendcs],
        [m4_esyscmd(build/git-version-gen .tarball-version)],
        [https://github.com/geoffjay/opendcs],
        [opendcs])

AC_CONFIG_HEADERS([config.h])
AC_CONFIG_SRCDIR([src/libdcs-core/object.vala])
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_AUX_DIR([build])

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
GTK_MIN_VERSION=3.0
ZMQ_MIN_VERSION=3.2.0

dnl This should be changed to create DCS_CORE_DEPS_{CFLAGS,LIBS}
PKG_CHECK_MODULES(DCS, [
        comedi      >= $COMEDI_MIN_VERSION
        gee-0.8     >= $GEE_MIN_VERSION
        gio-2.0     >= $GIO_MIN_VERSION
        libzmq      >= $ZMQ_MIN_VERSION
    ],[
        DCS_CORE_DEPS_VALAFLAGS="gee-0.8 gio-2.0 libzmq"
        DCS_ADD_VALAFLAGS([DCS_CORE_DEPS_VALAFLAGS])
        AC_SUBST([DCS_CORE_DEPS_VALAFLAGS])
    ],[
        AC_MSG_WARN([Core dependencies are missing.])
        AC_MSG_WARN([Try installing using: dnf install {comedi,libgee,zeromq3}-devel])
    ])

dnl Check if the user wants to build the CLI component
AC_ARG_WITH(cli,
  AS_HELP_STRING([--without-cli], [Do not build CLI applications]),
                 [try_cli=$withval], [try_cli=yes])

HAVE_CURSES=no
AS_IF([test "x$try_cli" = "xyes"], [
    PKG_CHECK_MODULES([DCS_CLI_DEPS], [ncurses >= $CURSES_MIN_VERSION], [
        DCS_CHECK_PACKAGES([ncurses], [HAVE_CURSES=yes])
        DCS_CLI_DEPS_VALAFLAGS="--pkg ncurses"
        AC_SUBST([DCS_CLI_DEPS_VALAFLAGS])
    ], [
        AC_MSG_WARN([CLI dependencies not found.])
        AC_MSG_WARN([CLI applications will not be built.])
    ])
])

AM_CONDITIONAL(BUILD_CLI, test "x$HAVE_CURSES" = "xyes")

dnl Check if the user wants to build the HMI component
AC_ARG_WITH(hmi,
  AS_HELP_STRING([--without-hmi], [Do not build HMI applications]),
                 [try_hmi=$withval], [try_hmi=yes])

HAVE_GTK=no
AS_IF([test "x$try_hmi" = "xyes"], [
    PKG_CHECK_MODULES([DCS_HMI_DEPS], [gtk+-3.0 >= $GTK_MIN_VERSION], [
        DCS_CHECK_PACKAGES([gtk+-3.0], [HAVE_GTK=yes])
        DCS_HMI_DEPS_VALAFLAGS="--pkg gtk+-3.0"
        AC_SUBST([DCS_HMI_DEPS_VALAFLAGS])
    ], [
        AC_MSG_WARN([HMI dependencies not found.])
        AC_MSG_WARN([HMI applications will not be built.])
    ])
])

AM_CONDITIONAL(BUILD_HMI, test "x$HAVE_GTK" = "xyes")

dnl Use valadoc and gtk-doc for API documentation:
dnl This is on by default when using autogen.sh
dnl (so it is not on by default when building from a tarball with configure.)
AC_ARG_ENABLE(apidocs,
              AS_HELP_STRING([--enable-apidocs[=@<:@no/auto/yes@:>@]],
                             [Create API documentation using valadoc and GTK-Doc]),,
              [enable_apidocs=auto])

HAVE_VALADOC=no
AS_IF([test "x$enable_apidocs" != "xno"], [
    AC_PATH_PROG(VALADOC, valadoc, :)
    AS_IF([test -x "$VALADOC"], [
        HAVE_VALADOC=yes
        AC_SUBST(VALADOC)
        PKG_CHECK_MODULES([GTKDOC],[gtk-doc >= 1.0],,
            AS_IF([test "x$enable_apidocs" == "xyes"],
                  [AC_MSG_ERROR([Unable to find gtk-doc])],
                  [HAVE_VALADOC=no]))
    ], [
        AS_IF([test "x$enable_apidocs" == "xyes"], AC_MSG_ERROR([Unable to find valadoc]))
    ])
])

AM_CONDITIONAL(ENABLE_VALADOC, test "x$HAVE_VALADOC" = "xyes")

AC_CONFIG_FILES([
    Makefile
    docs/Makefile
    docs/api/Makefile
    docs/man/Makefile
    docs/man/dcs-cli/Makefile
    docs/man/dcs-monitor/Makefile
    docs/rtd/Makefile
    src/dcs-cfgd/Makefile
    src/dcs-cli/Makefile
    src/dcs-ctrld/Makefile
    src/dcs-hmi/Makefile
    src/dcs-logd/Makefile
    src/dcs-monitor/Makefile
    src/libdcs-core/Makefile
    src/libdcs-devices/Makefile
    src/libdcs-devices/mux/Makefile
    src/libdcs-devices/poll/Makefile
    src/libdcs-devices/stream/Makefile
    src/libdcs-hmi/Makefile
    src/libdcs-log/Makefile
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

    CLI:                ${HAVE_CURSES}
    HMI:                ${HAVE_GTK}
    API Documentation:  ${HAVE_VALADOC}

    > Configure Complete

    Now type 'make' to build $PACKAGE
])
