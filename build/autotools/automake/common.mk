shareddir = $(datadir)/libdcs
sysconfigdir = $(sysconfdir)
devicedir = @DCS_DEVICE_DIR@

vala-clean:
		rm -f `find . -name "*.stamp"`
