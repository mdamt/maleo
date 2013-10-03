using Gtk;

public class AppWindow: Window {
  ConfigXML config = null;

  public AppWindow (ConfigXML config) {
    this.config = config;
    var w = new WebView ();
    add(w);
    w.load_uri ("file://" + config.directory + "/" + config.content);
    var f = w.window_features;
    if (config.width != -1) {
      f.width = config.width;
    }
    if (config.height != -1) {
      f.height = config.height;
    }

    destroy.connect (() => {
      Gtk.main_quit ();
    });
  }
}
