const OpenDCS = imports.gi.OpenDCS;

function main() {
    let obj = new OpenDCS.Object({'id': 'test'});
    print("Object hash: ", obj.hash);
}

main();
