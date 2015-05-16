bin_PROGRAMS = hmi

hmi_VALAFLAGS = \
	--target-glib=2.38 -H $(srcdir)/libhmi.h -C -c \
	--pkg gio-2.0 --pkg curses --pkg posix

hmi_CFLAGS = \
	--include config.h -lm \
	$(DCS_CFLAGS)

hmi_LDADD = \
	$(DCS_LIBS)

hmi_headers = \
	libhmi.h

hmi_SOURCES = \
	main.vala

CLEANFILES = \
	*.stamp \
	stamp-h1 \
	$(srcdir)/libhmi.h
