using Curses;

public class DCS.Top : Application {

    private MainLoop loop;
    private IOChannel channel;

    private Top () {
        Object (application_id: "org.opendcs.top",
                flags: ApplicationFlags.FLAGS_NONE);
        set_inactivity_timeout (10000);

        loop = new MainLoop ();

        debug ("Top construction start");

        /* Setup STDIN as channel */
        channel = new IOChannel.unix_new (Posix.STDIN_FILENO);
        if (channel == null)
            error ("Unable to monitor STDIN");

        var stat = channel.add_watch (IOCondition.IN | IOCondition.HUP,
                                      (IOFunc)input_cb);
        if (stat == 0)
            error ("Unable to add watch on IO channel");

        debug ("Top construction complete");
    }

    public override void activate () {
        debug ("%s activated", application_id);

        setup_window ();
        loop.run ();
    }

    private void setup_window () {
        debug ("Create curses window");
        initscr ();

        start_color ();
        init_pair (1, Color.BLACK, Color.WHITE);

        var win = new Window (LINES, COLS, 0, 0);
        win.bkgdset (COLOR_PAIR (0));
        win.addstr ("OpenDCS - 0MQ SUB Top Utility");
        win.clrtobot ();
    }

    private bool input_cb (IOChannel source, IOCondition condition) {
        char[] buf = new char[1024];
        size_t bytes_read;

        if (condition == IOCondition.HUP) {
            debug ("The connection has been broken");
            return false;
        }

        try {
            switch (source.read_chars (buf, out bytes_read)) {
                case IOStatus.NORMAL:
                    if (buf[0] == 'q') {
                        endwin ();
                        loop.quit ();
                    }
                    return true;
                case IOStatus.ERROR:
                    debug ("Input channel error");
                    return false;
                case IOStatus.EOF:
                    warning ("No input data available");
                    return true;
                case IOStatus.AGAIN:
                    return true;
                default:
                    return_val_if_reached (false);
            }
        } catch (ConvertError e) {
            warning ("ConvertError: %s", e.message);
            return false;
        } catch (IOChannelError e) {
            warning ("IOChannelError: %s", e.message);
            return false;
        }
    }

    public static int main (string[] args) {
        Top app = new Top ();
        int status = app.run (args);

        return status;
    }
}
