bin_PROGRAMS = dev

dev_VALAFLAGS = \
	-H $(srcdir)/libdev.h -C -c --pkg libzmq

dev_CFLAGS = \
	--include config.h \
	$(ASYNC_BUS_CFLAGS)

dev_LDADD = \
	$(ASYNC_BUS_LIBS)

dev_headers = \
	dev.h \
	libdev.h

dev_SOURCES = \
	main.vala

CLEANFILES = \
	*.stamp \
	stamp-h1 \
	$(srcdir)/libdev.h
