/**
 * Errors related to device types.
 */
public errordomain DCS.DeviceError {
    NO_CONFIGURABLE_SETTINGS,
    HARDWARE_NOT_AVAILABLE
}

/**
 * DCSDeviceCapabilities is a set of flags that represent various
 * capabilities of plugins.
 */
[Flags]
public enum DCS.DeviceCapabilities {
    NONE = 0,

    /* Diagnostics (DIAGE) support */
    DIAGNOSTICS,
}

public class DCS.Device : DCS.Object {

    public DeviceCapabilities capabilities { get; construct set; }

    public string name { get; construct; }

    public string title { get; construct set; }

    public string description { get; construct; }

    /**
     * Create an instance of the plugin.
     *
     * @param name  The non-human-readable name for the plugin, used in the
     *              OpenDCS configuration file.
     * @param title An optional human-readable name provided by the plugin. If
     *              the title is empty then the name will be used.
     * @param description  An optional human-readable description service
     *                     provided by the plugin.
     * @param capabilities The functionality and services that the plugin
     *                     provides.
     */
    public Device (string  name,
                   string? title,
                   string? description = null,
                   DeviceCapabilities capabilities = DeviceCapabilities.NONE) {
        GLib.Object (name : name,
                     title : title,
                     description : description,
                     capabilities : capabilities);
    }

    public override void constructed () {
        base.constructed ();

        if (this.title == null) {
            this.title = this.name;
        }
    }
}
