#!/usr/bin/env perl

use Glib::Object::Introspection;
Glib::Object::Introspection->setup(
    basename => 'OpenDCS',
    version => '0.1',
    package => 'OpenDCS');

$object = OpenDCS::Object->new();
$object->set_hash(0);
print $object->get_hash();
exit 0;
