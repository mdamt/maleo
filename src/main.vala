using Gtk;

int main (string[] args) {
    Intl.bindtextdomain( Config.GETTEXT_PACKAGE, Config.LOCALEDIR );
    Intl.bind_textdomain_codeset( Config.GETTEXT_PACKAGE, "UTF-8" );
    Intl.textdomain( Config.GETTEXT_PACKAGE );

    Gtk.init (ref args);

    if (args.length > 1) {
      var c = new ConfigXML (args[1]);

      var w = new AppWindow (c.directory + "/" + c.content);
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
