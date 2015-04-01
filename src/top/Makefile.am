bin_PROGRAMS = top

top_VALAFLAGS = \
	--target-glib=2.38 -H $(srcdir)/libtop.h -C -c \
	--pkg gio-2.0 --pkg curses --pkg posix

top_CFLAGS = \
	--include config.h -lm \
	$(DCS_CFLAGS)

top_LDADD = \
	$(DCS_LIBS)

top_headers = \
	libtop.h

top_SOURCES = \
	main.vala

CLEANFILES = \
	*.stamp \
	stamp-h1 \
	$(srcdir)/libtop.h
