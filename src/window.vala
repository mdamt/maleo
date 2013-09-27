using Gtk;

public class AppWindow: Window {

  public AppWindow () {
    var w = new WebView ();
    w.show();
    add(w);
    show_all();
  }
}
