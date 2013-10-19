using Gtk;

public class AppWindow: Window {
  ConfigXML config = null;
  ScrolledWindow scrolledWindow = null;

  public AppWindow (ConfigXML config) {
    scrolledWindow = new ScrolledWindow (null, null);
    this.config = config;
    var w = new WebView (config);
    add(scrolledWindow);
    scrolledWindow.add(w);
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
