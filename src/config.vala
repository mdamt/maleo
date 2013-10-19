using Xml.XPath;
using Xml;

/*
 Reads config.xml file located in the path specified when instantiating the class.
 The widget spec: http://www.w3.org/TR/widgets

*/
public class ConfigXML {
  Xml.Doc* doc = null;
  Xml.XPath.Object* obj = null;
  Context ctx = null;

  /* Holds the entry point of the application */ 
  public string content {
    get;
    private set;
    default = null;
  }

  /* Holds the directory of the application
  where the runtime needs to look into */
  public string directory {
    get;
    private set;
    default = null;
  }

  /* Holds the application title
     shown as the application window title */
  public string title {
    get;
    private set;
    default = null;
  }

  /* Holds the recommended application window's height*/
  public int height {
    get;
    private set;
    default = -1;
  }

  /* Holds the recommended application window's width */
  public int width {
    get;
    private set;
    default = -1;
  }

  /* Holds value whether runtime needs to load seed */
  public bool enable_seed {
    get;
    private set;
    default = true;
  }

  public ConfigXML(string path) {
    Parser.init ();
    doc = Parser.parse_file (path + "/config.xml");

    if (doc == null) {
      return;
    }

    ctx = new Context (doc);
    if (ctx == null) {
      cleanup ();
      return;
    }

    ctx.register_ns("x", "http://www.w3.org/ns/widgets");
    content = get_string_from_attribute ("/x:widget/x:content", "src");
    directory = path;
    var t = get_string_from_path ("/x:widget/x:name");
    if (t.length > 0) {
      title = t[0];
    }

    var w = get_string_from_attribute ("/x:widget", "width");
    if (w != null) {
      width = int.parse(w);
    }

    w = get_string_from_attribute ("/x:widget", "height");
    if (w != null) {
      height = int.parse(w);
    }

    w = get_string_from_preference("enable-seed");
    if (w == "false") {
      enable_seed = false;
    }
    cleanup ();
  }

  string[] get_string_from_path(string path) {
    string[] return_values = {};
    obj = ctx.eval_expression (path);
    if (obj == null || obj->nodesetval == null) {
      cleanup();
      return return_values;
    }
      
    for (int i = 0; i < obj->nodesetval->length (); i++) {
      Xml.Node* node = obj->nodesetval->item (i);
      return_values += node->get_content();
    }

    return return_values;
  }

  string? get_string_from_attribute(string path, string attribute) {
    string return_value = null;
    obj = ctx.eval_expression (path);
    if (obj == null || obj->nodesetval == null) {
      cleanup();
      return return_value;
    }
      
    for (int i = 0; i < obj->nodesetval->length (); i++) {
      Xml.Node* node = obj->nodesetval->item (i);
      Xml.Attr* attr = null;
      attr = node->properties;

      while ( attr != null )
      {
        if (attr->name == attribute) {
          return_value = attr->children->content + ""; // copy
          break;
        }
        attr = attr->next;
      }
    }

    return return_value;
  }

  string? get_string_from_preference(string name) {
    string return_value = null;
    obj = ctx.eval_expression ("/x:widget/x:preference");
    if (obj == null || obj->nodesetval == null) {
      cleanup();
      return return_value;
    }
      
    for (int i = 0; i < obj->nodesetval->length (); i++) {
      Xml.Node* node = obj->nodesetval->item (i);
      Xml.Attr* attr = null;
      attr = node->properties;

      var pickupNow = false;
      while ( attr != null )
      {
        if (attr->name == "name") {
          pickupNow = false;
          if (attr->children->content == name) {
            pickupNow = true;
          }
        }
        if (attr->name == "value" && pickupNow) {
          return_value = attr->children->content + ""; //copy
          break;
        }
        attr = attr->next;
      }
    }

    return return_value;
  }

  void cleanup () {
    // libxml-2.0 binding requires us to do the cleanup manually
    if (obj != null) {
      delete(obj);
    }
    if (doc != null) {
      delete(doc);
    }
  }
}
