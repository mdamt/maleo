using Gtk;
using Gee;
using GLib;

public class Maleo : Object {
  
  public HashMap<string, Command> commands;

  public static int main(string[] args){

    Intl.bindtextdomain( Config.GETTEXT_PACKAGE, Config.LOCALEDIR );
    Intl.bind_textdomain_codeset( Config.GETTEXT_PACKAGE, "UTF-8" );
    Intl.textdomain( Config.GETTEXT_PACKAGE );

    var maleo = new Maleo();
    return maleo.run(args);
  }

  public Maleo(){
    Utils.init();
    this.commands = new HashMap<string, Command>(str_hash, str_equal);
    this.commands.set("help", new Help(this));
    this.commands.set("run", new Run(this));
  }

  public int run(string[] args) {
    var command_line = "";
    string[] arguments = {};
    if (args.length == 1) {
      command_line = "run";
    } else {
      command_line = args[1];
      if (args.length > 1) {
        arguments = args[2:args.length];
      }
    }

    var command = get_command(command_line);
    if (command != null) {
      return command.run(arguments);
    } else {
      arguments = args[1:args.length];
      command = get_command("run");
      int ret = command.run(arguments);
      if (ret > 0) {
        stderr.printf("%s\n", args[1]);
      }
    }

    return 0;
  }

  public Command? get_command (string line) {
    return this.commands.get(line);
  }
}

public abstract class Command {
  protected Maleo maleo;

  public Command (Maleo maleo) {
    this.maleo = maleo;
  }

  public abstract string name { get; }
  public abstract string description { get; }
  public abstract string help { get; }
  public abstract int run (string[] args);
}


/*int main (string[] args) {
    // TODO: This must be killed when the UI is killed
    GLib.Pid nodejs_pid = 0;
    Intl.bindtextdomain( Config.GETTEXT_PACKAGE, Config.LOCALEDIR );
    Intl.bind_textdomain_codeset( Config.GETTEXT_PACKAGE, "UTF-8" );
    Intl.textdomain( Config.GETTEXT_PACKAGE );

    Gtk.init (ref args);

    if (args.length > 1) {
      var c = new ConfigXML (args[1]);

      if (c.nodejs_app != null) {
        var node = Environment.find_program_in_path("nodejs");
        if (node != null) {
          string[] argv = {node, c.nodejs_app};
          try {
            GLib.Process.spawn_async (c.directory, argv, null, 0, null, out nodejs_pid);
          } catch (SpawnError e) {
            stderr.printf("Unable to execute node application: %s\n", e.message);
            return -1;
          }
        } else {
          var path = Environment.get_variable("PATH");
          stderr.printf("Unable to find nodejs in your path: %s.\n",path);
        }
      }

      var w = new AppWindow (c);
      if (c.width != -1) {
        w.default_width = c.width;
      }

      if (c.height != -1) {
        w.default_height = c.height;
      }
      w.title = c.title.strip ();
      w.show_all();
    }

    Gtk.main ();
    return 0;
}*/
