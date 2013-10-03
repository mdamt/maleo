using Gtk;

public class AppWindow: Window {

  public AppWindow (string content) {
    var w = new WebView ();
    add(w);
    w.load_uri ("file://" + content);

    destroy.connect (() => {
      Gtk.main_quit ();
    });
  }
}
