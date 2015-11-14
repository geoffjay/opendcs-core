include $(top_srcdir)/build/autotools/automake/defaults.mk
include $(srcdir)/filelist.mk

AM_VERSION=$(MAJOR_VERSION)_$(MINOR_VERSION)
LIB_VERSION=$(MAJOR_VERSION).$(MINOR_VERSION)

libdcsincdir = $(includedir)/dcs-$(LIB_VERSION)

libdcsinc_HEADERS = libdcs.h

lib_LTLIBRARIES = libdcs-$(LIB_VERSION).la

libdcs_$(AM_VERSION)_la_SOURCES = \
	$(LIBDCS_CORE_VAPI_SOURCE_FILES) \
	$(LIBDCS_CORE_NONVAPI_SOURCE_FILES)

libdcs_$(AM_VERSION)_la_VALAFLAGS = \
	-H libdcs.h -C --library=dcs-$(LIB_VERSION) \
	--gir=OpenDCS-$(LIB_VERSION).gir \
	--vapidir=$(srcdir) \
	--pkg posix \
	$(DCS_CORE_DEPS_VALAFLAGS)

libdcs_$(AM_VERSION)_la_CFLAGS = \
	$(DCS_CORE_DEPS_CFLAGS) \
	-DPLUGIN_DIR='"$(plugindir)"' \
	-include config.h \
	-DG_LOG_DOMAIN='"libdcs"'

libdcs_$(AM_VERSION)_la_LIBADD = \
	$(DCS_CORE_DEPS_LIBS) \
	-lm

DCS_VERSION=$(MAJOR_VERSION):$(MINOR_VERSION):$(MICRO_VERSION)
libdcs_$(AM_VERSION)_la_LDFLAGS = \
	$(DCS_DATA_DIR_DEFINES) \
	-version-info $(DCS_VERSION)

BUILT_SOURCES = \
	dcs-$(LIB_VERSION).vapi \
	dcs.h

VAPI_FILES = dcs-$(LIB_VERSION).vapi
DEPS_FILES = dcs-$(LIB_VERSION).deps

vapidir = $(VAPIDIR)
vapi_DATA = $(VAPI_FILES) $(DEPS_FILES)
dcs-$(LIB_VERSION).vapi libdcs.h OpenDCS-$(LIB_VERSION).gir: libdcs_$(AM_VERSION)_la_vala.stamp

-include $(INTROSPECTION_MAKEFILE)
INTROSPECTION_GIRS=
INTROSPECTION_SCANNER_ARGS=
INTROSPECTION_COMPILER_ARGS= -l libdcs-$(LIB_VERSION).so.0
# XXX this does nothing for now, test removing later
$(builddir)/OpenDCS-$(LIB_VERSION).gir: $(srcdir)/OpenDCS-$($MAJOR_VERSION).$(MINOR_VERSION).gir
	$(AM_V_GEN)$(SED) -e 's,DCS\.,DCS.,g' -e 's,namespace name="DCS",namespace name="DCS",g' $< >$@
GIRS = OpenDCS-$(LIB_VERSION).gir

girdir=$(datadir)/gir-1.0
dist_gir_DATA = $(GIRS)

typelibdir = $(libdir)/girepository-1.0
nodist_typelib_DATA = $(GIRS:.gir=.typelib)

DISTCLEANFILES = OpenDCS-$(LIB_VERSION).typelib

MAINTAINERCLEANFILES = Makefile.in $(BUILT_SOURCES)

EXTRA_DIST = \
	config.vapi \
	$(VAPI_FILES) \
	$(DEPS_FILES) \
	$(BUILT_SOURCES) \
	OpenDCS-$(LIB_VERSION).gir

vala-clean:
	rm -f `find . -name "*.stamp"`

-include $(top_srcdir)/git.mk
