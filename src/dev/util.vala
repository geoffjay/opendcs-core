namespace DCS {

    public void comedi_command_prepare (Comedi.Command command,
                                        uint resolution_ns,
                                        uint scan_period_nanosec,
                                        int nchan,
                                        int subdevice,
                                        uint[] chanlist) {
        uint convert_nanosec =
            (uint)(resolution_ns *
                (GLib.Math.round ((double)scan_period_nanosec /
                                  ((double)(nchan * resolution_ns)))));

        command.subdev = subdevice;
        command.flags = 0;//TriggerFlag.WAKE_EOS;
        command.start_src = Comedi.TriggerSource.NOW;
        command.start_arg = 0;
        command.scan_begin_src = Comedi.TriggerSource.FOLLOW;
        //command.scan_begin_arg = scan_period_nanosec; //nanoseconds;
        command.convert_src = Comedi.TriggerSource.TIMER;
        command.convert_arg = convert_nanosec;
        command.scan_end_src = Comedi.TriggerSource.COUNT;
        command.scan_end_arg = nchan;
        command.stop_src = Comedi.TriggerSource.NONE;//COUNT;
        command.stop_arg = 0;
        command.chanlist = chanlist;
        command.chanlist_len = nchan;
    }

    public void comedi_command_test (Comedi.Device device, Comedi.Command command) {
        var ret = -1;

        ret = device.command_test (command);
        if (ret < 0)
            error ("Command test error");
        else
            debug ("Command test returned: %d", ret);

        comedi_command_dump (command);

        ret = device.command_test (command);
        if (ret < 0)
            error ("Command test error");
        else
            debug ("Command test returned: %d", ret);

        comedi_command_dump (command);
    }

    private void comedi_command_dump (Comedi.Command command) {
        string dump = "\nsubdevice:           %u\n".printf (command.subdev);
        dump += "start:      %-8s %u\n".printf (comedi_command_source (command.start_src),
                                                command.start_arg);
        dump += "scan_begin: %-8s %u\n".printf (comedi_command_source (command.scan_begin_src),
                                                command.scan_begin_arg);
        dump += "convert:    %-8s %u\n".printf (comedi_command_source (command.convert_src),
                                                command.convert_arg);
        dump += "scan_end:   %-8s %u\n".printf (comedi_command_source (command.scan_end_src),
                                                command.scan_end_arg);
        dump += "stop:       %-8s %u\n".printf (comedi_command_source (command.stop_src),
                                                command.stop_arg);
        debug (dump);
    }

    private string comedi_command_source (uint src) {
        string buf = "";

        if ((src & Comedi.TriggerSource.NONE) != 0)     buf = "none   |";
        if ((src & Comedi.TriggerSource.NOW) != 0)      buf = "now    |";
        if ((src & Comedi.TriggerSource.FOLLOW) != 0)   buf = "follow |";
        if ((src & Comedi.TriggerSource.TIME) != 0)     buf = "time   |";
        if ((src & Comedi.TriggerSource.TIMER) != 0)    buf = "timer  |";
        if ((src & Comedi.TriggerSource.COUNT) != 0)    buf = "count  |";
        if ((src & Comedi.TriggerSource.EXT) != 0)      buf = "ext    |";
        if ((src & Comedi.TriggerSource.INT) != 0)      buf = "int    |";
        if ((src & Comedi.TriggerSource.OTHER) != 0)    buf = "other  |";

        if (Posix.strlen (buf) == 0)
            buf = "unknown src";

        return buf;
    }
}
