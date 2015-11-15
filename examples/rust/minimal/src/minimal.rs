#[macro_use]
extern crate grust;

extern crate opendcs_0_1 as dcs;

use dcs::Object;

fn main() {
    let object = Object::new("test");
    println!("Object hash: {}", object.get_hash());
}
