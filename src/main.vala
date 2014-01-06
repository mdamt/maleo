using Gtk;
using Gee;
using GLib;

public class Maleo : Object {

  // set of commands
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

    // avalilable commands
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

// an abstract class defining a command interface
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

