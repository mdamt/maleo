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
  public string content {
    get;
    private set;
    default = null;
  }

  public string directory {
    get;
    private set;
    default = null;
  }

  public string title {
    get;
    private set;
    default = null;
  }

  public int height {
    get;
    private set;
    default = -1;
  }

  public int width {
    get;
    private set;
    default = -1;
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
