bin_PROGRAMS = mux

mux_VALAFLAGS = \
	-H $(srcdir)/libmux.h -C -c --pkg libzmq

mux_CFLAGS = \
	--include config.h \
	$(ASYNC_BUS_CFLAGS)

mux_LDADD = \
	$(ASYNC_BUS_LIBS)

mux_headers = \
	mux.h \
	libmux.h

mux_SOURCES = \
	main.vala

CLEANFILES = \
	*.stamp \
	stamp-h1 \
	$(srcdir)/libmux.h
