include $(top_srcdir)/build/autotools/automake/defaults.mk
include $(srcdir)/filelist.mk

libdcsincdir = $(includedir)/dcs-0.3

libdcsinc_HEADERS = libdcs.h

lib_LTLIBRARIES = libdcs-0.3.la

libdcs_0_3_la_SOURCES = \
	$(LIBDCS_CORE_VAPI_SOURCE_FILES) \
	$(LIBDCS_CORE_NONVAPI_SOURCE_FILES)

libdcs_0_3_la_VALAFLAGS = \
	-H libdcs.h -C --library=dcs-0.3 \
	--gir=OpenDCS-0.3.gir \
	--vapidir=$(srcdir) \
	--pkg posix \
	$(DCS_CORE_DEPS_VALAFLAGS)

libdcs_0_3_la_CFLAGS = \
	$(DCS_CORE_DEPS_CFLAGS) \
	-DPLUGIN_DIR='"$(plugindir)"' \
	-include config.h \
	-DG_LOG_DOMAIN='"libdcs"'

libdcs_0_3_la_LIBADD = \
	$(DCS_CORE_DEPS_LIBS) \
	-lm

DCS_VERSION=$(MAJOR_VERSION):$(MINOR_VERSION):$(MICRO_VERSION)
libdcs_0_3_la_LDFLAGS = \
	$(DCS_DATA_DIR_DEFINES) \
	-version-info $(DCS_VERSION)

BUILT_SOURCES = \
	dcs-0.3.vapi \
	dcs.h

VAPI_FILES = dcs-0.3.vapi
DEPS_FILES = dcs-0.3.deps

vapidir = $(VAPIDIR)
vapi_DATA = $(VAPI_FILES) $(DEPS_FILES)
dcs-0.3.vapi libdcs.h OpenDCS-0.3.gir: libdcs_0_3_la_vala.stamp

-include $(INTROSPECTION_MAKEFILE)
INTROSPECTION_GIRS=
INTROSPECTION_SCANNER_ARGS=
INTROSPECTION_COMPILER_ARGS= -l libdcs-0.3.so.0
# XXX this does nothing for now, test removing later
$(builddir)/OpenDCS-0.3.gir: $(srcdir)/OpenDCS-$($MAJOR_VERSION).$(MINOR_VERSION).gir
	$(AM_V_GEN)$(SED) -e 's,DCS\.,DCS.,g' -e 's,namespace name="DCS",namespace name="DCS",g' $< >$@
GIRS = OpenDCS-0.3.gir

girdir=$(datadir)/gir-1.0
dist_gir_DATA = $(GIRS)

typelibdir = $(libdir)/girepository-1.0
nodist_typelib_DATA = $(GIRS:.gir=.typelib)

DISTCLEANFILES = OpenDCS-0.3.typelib

MAINTAINERCLEANFILES = Makefile.in $(BUILT_SOURCES)

EXTRA_DIST = \
	config.vapi \
	$(VAPI_FILES) \
	$(DEPS_FILES) \
	$(BUILT_SOURCES) \
	OpenDCS-0.3.gir

vala-clean:
	rm -f `find . -name "*.stamp"`

-include $(top_srcdir)/git.mk
