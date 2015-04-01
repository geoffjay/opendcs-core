bin_PROGRAMS = dev

dev_VALAFLAGS = \
	--target-glib=2.38 -H $(srcdir)/libdev.h -C -c \
	--pkg gio-2.0 --pkg libzmq --pkg comedi

dev_CFLAGS = \
	--include config.h -lm \
	$(DCS_CFLAGS)

dev_LDADD = \
	$(DCS_LIBS)

dev_headers = \
	libdev.h

dev_SOURCES = \
	main.vala \
	util.vala

CLEANFILES = \
	*.stamp \
	stamp-h1 \
	$(srcdir)/libdev.h
