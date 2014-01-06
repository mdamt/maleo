using Gee;
using GLib;

private class Help : Command {
  public override  string name {
    get { return "help";}
  }

  public override string description {
    get { return "Display help";}
  }

  public override string help {
    get { return "Usage: \n  maleo help [COMMAND] \n\nExamples: \n maleo help run    display help for `run` command"; }
  }

  public Help (Maleo maleo) {
    base (maleo);
  }

  public override int run (string[] args) {
    if (args.length == 0) {
      Utils.print_line ("Usage: \n  maleo [COMMAND] [PARAM...] \n\nAvailable commands:\n");
      MapIterator<string, Command> iter = this.maleo.commands.map_iterator ();
      Utils.indent ();
      while (iter.next () == true) {
        Utils.print_line ("%-20s  %s", iter.get_key(), iter.get_value().description);
      }
      Utils.unindent ();
    }
    else {
      Command cmd = this.maleo.commands.get (args[0]);
      if (cmd == null) {
        Utils.print_line ("Unrecognised command '%s'.", args[0]);
      }
      else {
        Utils.print_line ("%s", cmd.help);
      }
    }

    return 0;
  }

}
