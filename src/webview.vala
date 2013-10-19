using Gtk;
using WebKit;

public class WebView: WebKit.WebView {
    unowned Seed.Engine engine;
    public WebView (ConfigXML config) {
        var settings = new WebSettings();
        settings.enable_file_access_from_file_uris = true;
        settings.enable_universal_access_from_file_uris = true;
        settings.javascript_can_open_windows_automatically = true;
        set_settings(settings);

        if (config.enable_seed) {
          window_object_cleared.connect ((frame, context) => {
            unowned Seed.GlobalContext c = (Seed.GlobalContext) frame.get_global_context();
            engine = Seed.init_with_context(0, null, c);
          });
        }
    }
}
 
