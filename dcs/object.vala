public interface DCS.Object : GLib.Object {

    /**
     * Unique hash for the object.
     */
    public uint hash { get; set; }

    /**
     * Specifies whether the objects provided are equivalent for sorting.
     *
     * @param a one of the objects to use in the comparison.
     * @param b the other object to use in the comparison.
     *
     * @return  ``true`` or ``false`` depending on whether or not the hashes match
     */
    public virtual bool equal (Dactl.Object a, Dactl.Object b) {
        return a.hash == b.hash;
    }

    /**
     * Compares the object to another that is provided.
     *
     * @param a the object to compare this one against.
     *
     * @return  ``0`` if they contain the same hash, ``1`` otherwise
     */
    public virtual int compare (Dactl.Object a) {
        if (hash == a.hash) {
            return 0;
        } else {
            return 1;
        }
    }
}
