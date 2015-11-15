include $(top_srcdir)/build/autotools/automake/common.mk
include $(top_srcdir)/build/autotools/automake/defaults.mk
include $(srcdir)/filelist.mk

# Empty variables to be appended later
CLEANFILES=
BUILT_SOURCES=
AM_VALAFLAGS=

lib_LTLIBRARIES = libdcs-0.1.la

sources = \
	$(DCS_VAPI_SOURCE_FILES) \
	$(DCS_NONVAPI_SOURCE_FILES)

AM_CPPFLAGS = \
	$(DCS_CFLAGS) \
	-DDEVICE_DIR='"$(devicedir)"' \
	-include $(CONFIG_HEADER) \
	-DG_LOG_DOMAIN='"libdcs"' \
	-I$(top_srcdir)

AM_CFLAGS = \
	-g \
	$(VALA_CFLAGS) \
	-I$(top_builddir)

AM_VALAFLAGS = \
	$(DCS_DEPS_VALAFLAGS) \
	--vapidir=$(top_builddir)/vapi \
	--pkg posix \
	--library=dcs-0.1 \
	-H dcs.h \
	-C

libdcs_0_1_la_LIBADD = \
	$(DCS_DEPS_LIBS) \
	-lm

DCS_VERSION="$(MAJOR_VERSION)":"$(MINOR_VERSION)":"$(MICRO_VERSION)"
libdcs_0_1_la_LDFLAGS = \
	-Wl,--as-needed \
	-version-info $(DCS_VERSION)

$(sources:.vala=.c): $(sources)
	$(VALAC) $(AM_VALAFLAGS) $^

libdcs_0_1_la_SOURCES = \
	$(sources:.vala=.c)

# .h header file
dcs.h: libdcs-0.1.la
dcsdir = $(includedir)/dcs-$(API_VERSION)/libdcs
dcs_HEADERS = dcs.h

# .vapi Vala API file
dcs-0.1.vapi: libdcs-0.1.la
vapidir = $(datadir)/vala/vapi
dist_vapi_DATA = \
	dcs-0.1.vapi \
	dcs-0.1.deps

# .pc pkg-config file
pkgconfig_in = dcs-0.1.pc.in
pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = $(pkgconfig_in:.in=)

EXTRA_DIST = \
	$(sources) \
	$(pkgconfig_in)

GITIGNOREFILES = \
	$(sources:.vala=.c) \
	libdcs_0_1_la_vala.stamp

BUILT_SOURCES += \
	dcs.h \
	dcs-0.1.vapi

if HAVE_INTROSPECTION

### GObject Introspection
# dlname:
#   Extract our dlname like libfolks does, see bgo#658002 and bgo#585116
#   This is what g-ir-scanner does.
libdcs_dlname = \
    `$(SED) -n "s/^dlname='\([A-Za-z0-9.+-]\+\)'/\1/p" libdcs-0.1.la`

AM_VALAFLAGS += \
	--gir=OpenDCS-$(API_VERSION).gir

INTROSPECTION_GIRS = OpenDCS-$(API_VERSION).gir
INTROSPECTION_COMPILER_ARGS = -l $(libdcs_dlname)

OpenDCS-0.1.gir: libdcs-0.1.la

OpenDCS-0.1.typelib: $(INTROSPECTION_GIRS)
	$(INTROSPECTION_COMPILER) $(INTROSPECTION_COMPILER_ARGS)  $< -o $@

girdir = $(INTROSPECTION_GIRDIR)
gir_DATA = $(INTROSPECTION_GIRS)
typelibdir = $(INTROSPECTION_TYPELIBDIR)
typelib_DATA = OpenDCS-0.1.typelib
CLEANFILES += $(gir_DATA) $(typelib_DATA)

endif

CLEANFILES += \
	$(pkgconfig_DATA) \
	$(sources:.vala=.c) \
	dcs-0.1.vapi \
	dcs.h

-include $(top_srcdir)/git.mk
