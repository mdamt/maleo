using Gee;
using GLib;
using Gtk;

private class Run : Command {
  
  public static GLib.Pid nodejs_pid = 0;

  public override string name {
    get { return "run"; }
  }

  public override string description {
    get { return "run description"; }
  }

  public override string help {
    // todo: print help for using `run`; it also shows available options for running `run` command
    get { return "help run"; }
  }

  public Run (Maleo maleo) {
    base(maleo);
  }

  public override int run(string[] args){
    string path = ".";

    if (args.length > 0) {
      path = args[0];
    }

    File file = File.new_for_path(path);
    string fullpath = file.get_path();
    bool exists = file.query_exists();

    if (exists) {
      FileType type = file.query_file_type(FileQueryInfoFlags.NOFOLLOW_SYMLINKS);
      if (type == FileType.DIRECTORY) {
        bool valid_path = validate_path(fullpath);

        if (valid_path) {
          return show(fullpath, args);
        } else {
          stderr.printf("Not a valid maleo app\n");
          return 1;
        }

      } else {
        stderr.printf("Wrong type\n");
        return 1;
      }
    } else {
      stderr.printf("Not exist\n");
      return 1;
    }
  }

  private bool validate_path(string path) {
    string config = path + "/config.xml";
    File file_config = File.new_for_path(config);
    bool file_config_exists = file_config.query_exists();

    if (!file_config_exists) {
      return false;
    }

    return true;
  }

  private int show(string path, string[] args) {

    // following lines are copied from https://github.com/mdamt/maleo/src/main.vala
    // Copyright (C) 2013 Mohammad Anwari <mdamt@mdamt.net>

    Gtk.init(ref args);
    var c = new ConfigXML(path);

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
          var env_path = Environment.get_variable("PATH");
          stderr.printf("Unable to find nodejs in your path: %s.\n",env_path);
      }
    }

    var w = new AppWindow(c);
    if (c.width != -1) {
      w.default_width = c.width;
    }

    if (c.height != -1) {
      w.default_height = c.height;
    }

    if (c.title != null) {
      w.title = c.title.strip();
    }

    w.show_all();
    
    // kill nodejs process and quit the app
    w.destroy.connect(() => {
      if (nodejs_pid > 0) {
        Process.close_pid(nodejs_pid);
      }
      Gtk.main_quit();
    });

    Gtk.main();
    return 0;
  }
}
