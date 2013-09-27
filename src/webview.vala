using Gtk;
using WebKit;

public class WebView: WebKit.WebView {
    public WebView () {
        var settings = new WebSettings();
        settings.enable_file_access_from_file_uris = true;
        settings.enable_universal_access_from_file_uris = true;
        settings.javascript_can_open_windows_automatically = true;
        set_settings(settings);
    }

}
 
