include Makefile.decl

SUBDIRS = dcs-cfgd \
		  dcs-cli \
		  dcs-ctrld \
		  dcs-daqd \
		  dcs-logd \
		  dcs-monitor \
		  libdcs-core \
		  libdcs-devices \
		  libdcs-log \
		  $(NULL)

if BUILD_HMI
SUBDIRS += dcs-hmi \
		   libdcs-hmi \
		   $(NULL)
endif

MAINTAINERCLEANFILES = Makefile.in

vala-clean:
	rm -f `find . -name "*.stamp"`

-include $(top_srcdir)/git.mk
