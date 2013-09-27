using Gtk;

public class AppWindow: Window {

  public AppWindow (string content) {
    var w = new WebView ();
    w.show();
    stdout.printf("%s\n", content);
    add(w);
    w.load_uri ("file://" + content);
    show_all();

    destroy.connect (() => {
      Gtk.main_quit ();
    });
  }
}
