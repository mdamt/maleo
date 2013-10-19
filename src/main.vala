using Gtk;

int main (string[] args) {
    // TODO: This must be killed when the UI is killed
    GLib.Pid nodejs_pid = 0;
    Intl.bindtextdomain( Config.GETTEXT_PACKAGE, Config.LOCALEDIR );
    Intl.bind_textdomain_codeset( Config.GETTEXT_PACKAGE, "UTF-8" );
    Intl.textdomain( Config.GETTEXT_PACKAGE );

    Gtk.init (ref args);

    if (args.length > 1) {
      var c = new ConfigXML (args[1]);

      if (c.nodejs_app != null) {
        var node = Environment.find_program_in_path("nodejs");
        if (node != null) {
          string[] argv = {node, c.nodejs_app};
          try {
            GLib.Process.spawn_async (c.directory, argv, null, 0, null, out nodejs_pid);
          } catch (SpawnError e) {
            stderr.printf("Unable to execute node application: %s\n", e.message);
            return -1;
          }
        } else {
          var path = Environment.get_variable("PATH");
          stderr.printf("Unable to find nodejs in your path: %s.\n",path);
        }
      }

      var w = new AppWindow (c);
      if (c.width != -1) {
        w.default_width = c.width;
      }

      if (c.height != -1) {
        w.default_height = c.height;
      }
      w.title = c.title.strip ();
      w.show_all();
    }

    Gtk.main ();
    return 0;
}
