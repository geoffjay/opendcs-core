AC_PREREQ([2.69])

dnl ****************************************************************************
dnl Define versioning information
dnl ****************************************************************************
m4_define([opendcs_major_version],[0])
m4_define([opendcs_minor_version],[1])
m4_define([opendcs_micro_version],[0])
m4_define([opendcs_version],[opendcs_major_version.opendcs_minor_version.opendcs_micro_version])
m4_define([opendcs_interface_age],[0])
m4_define([opendcs_bugreport_url],
          [https://github.com/geoffjay/opendcs/issues])
m4_define([opendcs_debug_default],
          [m4_if(m4_eval(opendcs_minor_version % 2), [1], [yes], [minimum])])

dnl ****************************************************************************
dnl Initialize autoconf
dnl ****************************************************************************
AC_INIT([opendcs],[opendcs_version],[opendcs_bugreport_url])
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_SRCDIR([dcs/object.vala])
AC_CONFIG_MACRO_DIR([build/autotools])
AC_CONFIG_AUX_DIR([build])
AC_SUBST(ACLOCAL_AMFLAGS, "-I build/autotools")
AC_CANONICAL_HOST

dnl ****************************************************************************
dnl Make version info available to .in files
dnl ****************************************************************************
MAJOR_VERSION=opendcs_major_version
MINOR_VERSION=opendcs_minor_version
MICRO_VERSION=opendcs_micro_version
LIBDCS_VERSION=opendcs_version
AC_SUBST(MAJOR_VERSION)
AC_SUBST(MINOR_VERSION)
AC_SUBST(MICRO_VERSION)
AC_SUBST(LIBDCS_VERSION)

# This is used to identify a set of API compatible beatween versions
# - If new versions are compatible with the actual one, just leave this untouched
# - If new version breaks API change it in order to allow paralled installations
#   with old versions. Change name of pc files to use a new API too.
API_VERSION=opendcs_major_version.opendcs_minor_version
AC_SUBST([API_VERSION])

dnl ***********************************************************************
dnl Initialize automake
dnl ***********************************************************************
AM_SILENT_RULES([yes])
AM_INIT_AUTOMAKE([1.11 foreign subdir-objects tar-ustar no-dist-gzip dist-xz])
AM_MAINTAINER_MODE([enable])

dnl ***********************************************************************
dnl Internationalization
dnl ***********************************************************************
IT_PROG_INTLTOOL([0.50.1])
GETTEXT_PACKAGE=AC_PACKAGE_TARNAME
AC_SUBST(GETTEXT_PACKAGE)
AC_DEFINE_UNQUOTED([GETTEXT_PACKAGE], ["$GETTEXT_PACKAGE"], [GETTEXT package name])
AM_GLIB_GNU_GETTEXT

dnl ***********************************************************************
dnl Check for required programs
dnl ***********************************************************************
AC_PROG_CC
AM_PROG_CC_C_O
AC_PROG_INSTALL
AC_PROG_CXX
AM_PROG_VALAC([0.22.0])
AC_PATH_PROG([GLIB_GENMARSHAL], [glib-genmarshal])
AC_PATH_PROG([GLIB_MKENUMS], [glib-mkenums])
AC_PATH_PROG([GLIB_COMPILE_RESOURCES], [glib-compile-resources])
AC_HEADER_STDC
PKG_PROG_PKG_CONFIG([0.22])

dnl ***********************************************************************
dnl Setup debug and tracing support
dnl ***********************************************************************
AC_ARG_ENABLE(tracing,
              AS_HELP_STRING([--enable-tracing=@<:@no/yes@:>@],
                             [add extra debugging information @<:@default=no@:>@]),
              ,
              enable_tracing=no)
AS_IF([test "x$enable_tracing" = "xyes"],[enable_debug=yes ENABLE_TRACING=1],[ENABLE_TRACING=0])
AC_SUBST(ENABLE_TRACING)

AC_ARG_ENABLE(debug,
              AS_HELP_STRING([--enable-debug=@<:@no/minimum/yes@:>@],
                             [turn on debugging @<:@default=opendcs_debug_default@:>@]),
              ,
              enable_debug=opendcs_debug_default)
AS_CASE(["$enable_debug"],
        [yes],[
            DEBUG_CFLAGS="$DEBUG_CFLAGS -O0"
            DEBUG_CFLAGS="$DEBUG_CFLAGS -g"
        ],
        [minimum],[
            DEBUG_CFLAGS="$DEBUG_CFLAGS -DG_DISABLE_CAST_CHECKS"
        ],
        [no],[
            DEBUG_CFLAGS="$DEBUG_CFLAGS -DG_DISABLE_ASSERT"
            DEBUG_CFLAGS="$DEBUG_CFLAGS -DG_DISABLE_CHECKS"
            DEBUG_CFLAGS="$DEBUG_CFLAGS -DG_DISABLE_CAST_CHECKS"
        ],
        [])
AC_SUBST(DEBUG_CFLAGS)

BUGREPORT_URL=opendcs_bugreport_url
AC_SUBST(BUGREPORT_URL)

dnl XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
dnl Uncertainty starts here ---
dnl ---

dnl ***********************************************************************
dnl Check for required packages
dnl ***********************************************************************
GIO_MIN_VERSION=2.44.1
GLIB_MIN_VERSION=2.44.1
JSON_GLIB_MIN_VERSION=1.0.4

dnl This should be changed to create DCS_DEPS_{CFLAGS,LIBS}
PKG_CHECK_MODULES(DCS, [
        gio-2.0         >= $GIO_MIN_VERSION
        glib-2.0        >= $GLIB_MIN_VERSION
        json-glib-1.0   >= $JSON_GLIB_MIN_VERSION
    ],[
        DCS_DEPS_VALAFLAGS="--pkg json-glib-1.0 --pkg gio-2.0 --pkg gmodule-2.0"
        DCS_ADD_VALAFLAGS([DCS_DEPS_VALAFLAGS])
        AC_SUBST([DCS_DEPS_VALAFLAGS])
    ],[
        AC_MSG_WARN([Core dependencies are missing.])
        AC_MSG_WARN([Try installing using: dnf install {glib2,json-glib-1.0}-devel])
    ])

dnl ---
dnl Uncertainty stops here ---
dnl XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

dnl ***********************************************************************
dnl Check for supported plugins
dnl ***********************************************************************

dnl ***********************************************************************
dnl Check for supported devices (also plugins)
dnl ***********************************************************************

dnl ***********************************************************************
dnl Check for required python
dnl ***********************************************************************
enable_python_scripting=no
AS_IF([test "x$have_pygobject" = "xyes"],[
    AC_PATH_TOOL(PYTHON3_CONFIG, "python3-config")
    AS_IF([test -z "${PYTHON3_CONFIG}"],[
        AC_MSG_RESULT([Failed to locate python3-config.])
    ],[
        LIBDCS_CFLAGS="${LIBDCS_CFLAGS} `${PYTHON3_CONFIG} --includes`"
        LIBDCS_LIBS="${LIBDCS_LIBS} `${PYTHON3_CONFIG} --libs`"
        LIBDCS_LDFLAGS="${LIBDCS_LDFLAGS} `${PYTHON3_CONFIG} --ldflags`"
        enable_python_scripting=yes
    ])
])

dnl ***********************************************************************
dnl Define automake conditionals based on what we found
dnl ***********************************************************************
AM_CONDITIONAL(ENABLE_PYTHON_SCRIPTING, test x$enable_python_scripting != xno)
AM_CONDITIONAL(ENABLE_GJS_SCRIPTING, test x$enable_gjs_scripting != xno)

dnl ***********************************************************************
dnl Initialize Libtool
dnl ***********************************************************************
LT_PREREQ([2.2])
LT_INIT

dnl ***********************************************************************
dnl Additional C compiler flags
dnl ***********************************************************************
AX_CHECK_COMPILE_FLAG([-Werror=unknown-warning-option], [
    ax_compiler_flags_test="-Werror=unknown-warning-option"
], [
    ax_compiler_flags_test=""
])
AX_APPEND_COMPILE_FLAGS([ \
    -Wall \
    -Wcast-align \
    -Wdeclaration-after-statement \
    -Wempty-body \
    -Werror=format-security \
    -Werror=format=2 \
    -Wextra \
    -Wformat \
    -Wformat-nonliteral \
    -Wformat-security \
    -Winit-self \
    -Wmisleading-indentation \
    -Wmissing-include-dirs \
    -Wshift-negative-value \
    -Wnested-externs \
    -Wno-missing-field-initializers \
    -Wno-sign-compare \
    -Wno-strict-aliasing \
    -Wno-uninitialized \
    -Wno-unused-parameter \
    -Wpointer-arith \
    -Wredundant-decls \
    -Wreturn-type \
    -Wshadow \
    -Wswitch-default \
    -Wswitch-enum \
    -Wundef \
    -Wuninitialized \
], [], [$ax_compiler_flags_test])
AC_C_CONST

dnl ***********************************************************************
dnl Desktop settings support
dnl ***********************************************************************
GLIB_GSETTINGS

dnl ***********************************************************************
dnl Setup introspection
dnl ***********************************************************************
GOBJECT_INTROSPECTION_CHECK([1.42.0])

dnl ***********************************************************************
dnl Always build tests
dnl ***********************************************************************
AC_ARG_ENABLE([tests],
              AS_HELP_STRING([--enable-tests],
                             [Enable always building tests during 'make all' [default=no]]),
              [enable_tests=$enableval], [enable_tests=no])

AM_CONDITIONAL([ENABLE_TESTS], test "$enable_tests" = "yes")

dnl ***********************************************************************
dnl Use valadoc and gtk-doc for API documentation
dnl ***********************************************************************
AC_ARG_ENABLE(apidocs,
              AS_HELP_STRING([--enable-apidocs[=@<:@no/auto/yes@:>@]],
                             [Create API documentation using valadoc and GTK-Doc]),,
              [enable_apidocs=auto])

dnl ***********************************************************************
dnl Check for Dependencies needed to generate API Documentation
dnl ***********************************************************************
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

dnl ***********************************************************************
dnl Check if we should instrument our targets
dnl ***********************************************************************
AC_MSG_CHECKING([for --enable-profiling])
AC_ARG_ENABLE(profiling,
              AC_HELP_STRING([--enable-profiling],
                             [turn on runtime instrumentation [default=no]]),
              [enable_profiling=$enableval],
          [enable_profiling=no])
AS_IF([test "$enable_profiling" = "yes"],[
    ac_save_cflags="$CFLAGS"
    CFLAGS="$CFLAGS -pg"
    AC_LINK_IFELSE([AC_LANG_SOURCE([[int main() { return 0; }]])],
                   [PROFILING_CFLAGS="-pg"],
               [enable_profiling=no])
    CFLAGS="$ac_save_cflags $PROFILING_CFLAGS"
])
AC_MSG_RESULT([$enable_profiling])

dnl ***********************************************************************
dnl Process .in files
dnl ***********************************************************************
AC_CONFIG_FILES([
    Makefile

    build/Makefile
    build/autotools/Makefile
    build/autotools/automake/Makefile

    doc/Makefile
    doc/api/Makefile
    doc/rtd/Makefile

    dcs/Makefile
    dcs/dcs-$API_VERSION.pc

    examples/Makefile

    po/Makefile.in

    tests/Makefile
])

AC_OUTPUT

AC_MSG_NOTICE([

    $PACKAGE - $VERSION

    > Options

      Prefix ................................ : ${prefix}
      Libdir ................................ : ${srcdir}

    > Development Options

      Enable Debug .......................... : ${enable_debug}
      Enable Tracing ........................ : ${enable_tracing}
      Enable Profiling (-pg) ................ : ${enable_profiling}
      Build Test Suite ...................... : ${enable_tests}
      Build API reference ................... : ${enable_apidocs}

    > Scripting

      Python ................................ : ${enable_python_scripting}
      GJS ................................... : ${enable_gjs_scripting}

    > Plugins

      None yet

    > Devices

      None yet

    > Component Selection

      API Documentation ..................... : ${HAVE_VALADOC}

    > Configure Complete

    Now type 'make' to build $PACKAGE
])
