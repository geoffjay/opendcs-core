#!/usr/bin/env perl

use strict;
use warnings;

use Glib::Object::Introspection;
Glib::Object::Introspection->setup(
    basename => 'OpenDCS',
    version => '0.1',
    package => 'OpenDCS');

my $object = OpenDCS::Object->new('test');
print 'Object hash: ' . $object->get_property('hash');
exit 0;
