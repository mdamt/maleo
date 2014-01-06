using GLib;
using Gee;

private class Utils {
  private static uint indentation = 0;
  private static string indentation_string = "";

  public static void init() {
    Utils.indentation_string = "";
  }

  public static void indent ()
  {
    /* We indent in increments of two spaces */
    Utils.indentation += 2;
    Utils.indentation_string = string.nfill (Utils.indentation, ' ');
  }
  
  public static void unindent ()
  {
    Utils.indentation -= 2;
    Utils.indentation_string = string.nfill (Utils.indentation, ' ');
  }
  
  [PrintfFormat ()]
  public static void print_line (string format, ...)
  {
    var valist = va_list ();
    string output = format.vprintf (valist);
    stdout.printf ("%s%s\n", Utils.indentation_string, output);
  }
}
