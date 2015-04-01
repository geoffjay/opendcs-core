include $(top_srcdir)/Makefile.decl

noinst_PROGRAMS = $(TEST_PROGS)

TEST_PROGS += \
	sub \
	$(NULL)

test_VALAFLAGS = \
	$(VALAFLAGS) \
	--basedir $(top_srcdir) --pkg libzmq \
	$(NULL)

test_CPPFLAGS = \
	$(ASYNC_BUS_CFLAGS) \
	$(NULL)

test_LDADD = \
	$(ASYNC_BUS_LIBS) \
	$(NULL)

### individual test applications

sub_SOURCES = sub.vala
sub_VALAFLAGS = $(test_VALAFLAGS)
sub_CPPFLAGS = $(test_CPPFLAGS)
sub_LDADD = $(test_LDADD)
