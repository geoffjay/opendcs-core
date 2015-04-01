ACLOCAL_AMFLAGS = -I m4 ${ACLOCAL_FLAGS}

SUBDIRS = dev \
		  mux \
		  top

if BUILD_HMI
SUBDIRS += hmi
endif

MAINTAINERCLEANFILES = Makefile.in

vala-clean:
	rm -f `find . -name "*.stamp"`
