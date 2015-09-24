class AsyncBus.Test.Subscriber : GLib.Object {

    public static int main (string[] args) {

        var context = new ZMQ.Context ();
        var subscriber = ZMQ.Socket.create (context, ZMQ.SocketType.SUB);

        subscriber.connect ("tcp://localhost:9000");

        string filter = "Hello ";
        subscriber.setsockopt (ZMQ.SocketOption.SUBSCRIBE, filter, filter.length);

        while (true) {
            var msg = ZMQ.Msg ();

            //var n_read = msg.recv (subscriber);
            var n_read = subscriber.recvmsg (ref msg);
            if (n_read == -1)
                stderr.printf (":: Failed to read ::\n");

            size_t size = msg.size () + 1;
            uint8[] data = new uint8[size];
            Memory.copy (data, msg.data, size - 1);
            data[size - 1] = '\0';
            var str = (string)data;

            stdout.printf ("Read: %s\n", str);
        }

        return 0;
    }
}
