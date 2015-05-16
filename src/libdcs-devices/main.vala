/**
 * Publish all data read from the device
 *
 * Binds a PUB socket to tcp://_*_:9000
 */

/**
 * TODO: add a Comedi.Command
 * TODO: daemonize?
 * TODO: getopts for device, acquisition rate, port number
 * TODO: add a Cld.Context?
 * TODO: write prepare methods into vapi?
 */

public class DCS.Device : GLib.Object {

    private static bool running = false;

    private static string filename = "/dev/comedi1";
    private static int subdevice = 0;
    private static Comedi.Command command = Comedi.Command ();

    /**
     * Thread that reads data from the DAQ device.
     */
    private static async int measurement_command () throws ThreadError {
        SourceFunc callback = measurement_command.callback;
        int[] ret = new int[1];

        /* XXX command setup */
        int nchan = 32;
        int range = 4;
        uint scan_nsec = (uint)1e9;
        int resolution_nsec = 200;

        //var device = new Comedi.Device (filename);
        var device = new Comedi.Device ("/dev/comedi1");
        if (device == null)
            error ("Failed to open comedi device");

        Comedi.set_global_oor_behavior (Comedi.OorBehavior.NUMBER);

        var channels = new double[nchan];
        var chanlist = new uint[nchan];
        var range_info = new Comedi.Range[nchan];
        var maxdata = new uint[nchan];

        for (var i = 0; i < nchan; i++) {
            chanlist[i] = Comedi.pack (i, range, Comedi.AnalogReference.GROUND);
            range_info[i] = device.get_range (subdevice, i, range);
            maxdata[i] = device.get_maxdata (subdevice, i);
        }

        if (device.get_cmd_generic_timed (subdevice, out command, nchan, scan_nsec) < 0)
            debug ("Failed to setup generic timed command");

        debug ("subdev: %u", command.subdev);
        debug ("chanlist_len: %u", command.chanlist_len);

        DCS.comedi_command_prepare (command,
                                         resolution_nsec,
                                         scan_nsec,
                                         nchan,
                                         subdevice,
                                         chanlist);

        DCS.comedi_command_test (device, command);

        command.chanlist = chanlist;
        command.chanlist_len = nchan;
        if (command.stop_src == Comedi.TriggerSource.COUNT)
            command.stop_arg = nchan;

        /* XXX select setup */
        int nread = 0;
        int bufsz = 65536;
        ulong bytes_per_sample;
        int device_fd = -1;
        int subdev_flags = device.get_subdevice_flags ((uint)subdevice);

        if ((subdev_flags & Comedi.SubdeviceFlag.LSAMPL) != 0)
            bytes_per_sample = sizeof (uint);
        else
            bytes_per_sample = sizeof (ushort);

        device_fd = device.fileno ();
        Posix.fcntl (device_fd, Posix.F_SETFL, Posix.O_NONBLOCK);

        Thread<int> thread = new Thread<int>.try ("measurement_command", () => {
            var val = device.command (command);
            Comedi.perror ("waaa");
            debug ("Command start returned: %d", val);
            if (val < 0)
                error ("Failed to start comedi command");

            var size = device.get_buffer_size (subdevice);
            debug ("Comedi device buffer size: %u", (uint)size);

            while (running) {
                ushort[] buf = new ushort[bufsz];
                Posix.fd_set rdset;
                Posix.timespec timeout = Posix.timespec ();
                Posix.FD_ZERO (out rdset);
                Posix.FD_SET (device_fd, ref rdset);
                timeout.tv_sec = 0;
                timeout.tv_nsec = 50000000;

                Posix.sigset_t sigset = Posix.sigset_t ();
                Posix.sigemptyset (sigset);

                ret[0] = Posix.pselect (device_fd + 1, &rdset, null, null, timeout, sigset);

                if (ret[0] < 0) {
                    if (Posix.errno == Posix.EAGAIN)
                        warning ("Comedi read error");
                } else if ((Posix.FD_ISSET (device_fd, rdset)) == 1) {
                    nread = (int)Posix.read (device_fd, buf, bufsz);
                    var index = 0;
                    for (int i = 0; i < nread / bytes_per_sample; i++) {
                        channels[index] = Comedi.to_phys (buf[i], range_info[index], maxdata[index]);
                        index = (index >= nchan) ? 0 : index + 1;
                    }
                }
            }

            Idle.add ((owned)callback);

            return 0;
        });

        yield;

        device.cancel (subdevice);

        if (device.close () != 0)
            return -1;

        return ret[0];
    }

    /**
     * Thread responsible for publishing the data on the socket.
     */
    private static async int data_publisher () throws ThreadError {
        SourceFunc callback = data_publisher.callback;
        int[] ret = new int[1];

        running = true;

        Thread<int> thread = new Thread<int>.try ("data_publisher", () => {
            var context = new ZMQ.Context ();
            var publisher = ZMQ.Socket.create (context, ZMQ.SocketType.PUB);
            publisher.bind ("tcp://*:9000");

            uint8[] data = { 72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100 };

            while (running) {
                stdout.printf ("Sending data: %s\n", (string)data);
                var reply = ZMQ.Msg.with_data (data);
                //reply.send (publisher);
                publisher.sendmsg (ref reply);
                Thread.usleep (1000000);
            }

            Idle.add ((owned)callback);

            return 0;
        });

        yield;

        return ret[0];
    }

    public static int main (string[] args) {

        var loop = new MainLoop ();

        stdout.printf ("Async Bus - Device\n\n");

        /* Launch the thread for doing an asynchronous acquisition */
        measurement_command.begin ((obj, res) => {
            try {
                int result = measurement_command.end (res);
                stderr.printf (@"Measurement device exited: $result\n");
            } catch (ThreadError e) {
                string msg = e.message;
                stderr.printf (@"Measurement device error: $msg\n");
            }
        });

        /* Launch the thread that publishes the data over a TCP socket */
        data_publisher.begin ((obj, res) => {
            try {
                int result = data_publisher.end (res);
                stderr.printf (@"Data publisher exited: $result\n");
            } catch (ThreadError e) {
                string msg = e.message;
                stderr.printf (@"Data publisher error: $msg\n");
            }
            loop.quit ();
        });

        loop.run ();

        return 0;
    }
}
