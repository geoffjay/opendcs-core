bin_PROGRAMS = mux

mux_VALAFLAGS = \
	-H $(srcdir)/libmux.h -C -c --pkg libzmq

mux_CFLAGS = \
	--include config.h \
	$(DCS_CFLAGS)

mux_LDADD = \
	$(DCS_LIBS)

mux_headers = \
	libmux.h

mux_SOURCES = \
	main.vala

CLEANFILES = \
	*.stamp \
	stamp-h1 \
	$(srcdir)/libmux.h
