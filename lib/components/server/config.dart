import 'dart:io';

class ServerConfig {
  // Defaults
  static String host = "localhost";
  static int port = 8080;
  static String mongoHost = "localhost";
  static int mongoPort = 27017;
  static String? monogoURI;
}

void exitWithError(String string) {
  stderr.write("Exited with error: $string");
  exit(1);
}

void parseArgs(List<String> args) async {
  Iterator argsIter = args.iterator;
  while (argsIter.moveNext()) {
    String arg = argsIter.current.toString();

    switch (arg) {
      case '--host':
        {
          if (argsIter.moveNext() &&
              argsIter.current.isNotEmpty &&
              !argsIter.current.contains("-")) {
            ServerConfig.host = argsIter.current;
          } else {
            exitWithError("Invalid host");
          }
        }
        break;

      case '--port':
        {
          if (argsIter.moveNext() &&
              argsIter.current.isNotEmpty &&
              !argsIter.current.contains("-")) {
            var port = int.tryParse(argsIter.current);
            if (port == null) {
              exitWithError("Invalid port number");
            } else {
              ServerConfig.port = port;
            }
          } else {
            exitWithError("Invalid port");
          }
        }
        break;

      case '--mongo-host':
        {
          if (argsIter.moveNext() &&
              argsIter.current.isNotEmpty &&
              !argsIter.current.contains("-")) {
            ServerConfig.mongoHost = argsIter.current;
          } else {
            exitWithError("Invalid MongoDB host");
          }
        }
        break;

      case '--mongo-port':
        {
          if (argsIter.moveNext() &&
              argsIter.current.isNotEmpty &&
              !argsIter.current.contains("-")) {
            var port = int.tryParse(argsIter.current);
            if (port == null) {
              exitWithError("Invalid MongoDB port number");
            } else {
              ServerConfig.mongoPort = port;
            }
          }
        }
        break;

      case '--mongo-uri':
        {
          if (argsIter.moveNext() &&
              argsIter.current.isNotEmpty &&
              !argsIter.current.contains("-")) {
            ServerConfig.monogoURI = argsIter.current;
          } else {
            exitWithError("Invalid MongoDB URI");
          }
        }
        break;

      default:
        {
          exitWithError("Unknown argument: $arg");
        }
    }
  }
}
