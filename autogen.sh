#!/bin/sh
# Run this to generate all the initial makefiles, etc.

srcdir=`dirname $0`
test -z "$srcdir" && srcdir=.

PKG_NAME="async-bus"

(test -f $srcdir/configure.ac \
  && test -f $srcdir/README.md \
  && test -d $srcdir/src) || {
    echo -n "**Error**: Directory "\`$srcdir\'" does not look like the"
    echo " top-level $PKG_NAME directory"
    exit 1
}

aclocal && \
autoheader && \
automake --gnu --add-missing && \
autoconf && {
  echo "Running configure with $@"
  ./configure $@
}
