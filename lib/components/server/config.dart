import 'dart:convert';
import 'dart:io';

class ServerConfig {
  static late File file;
  static late Map<String, dynamic> _config;
  static late String host = 'localhost';
  static late int port = 8080;
  static late String mongoHost = 'localhost';
  static late int mongoPort = 27017;
  static late String? monogoURI = null;
  static late String? currentForm = null;

  static loadFrom(String _file) async {
    file = File(_file);
    if (!await file.exists()) {
      await file.create();
      stdout.writeln('Created config file because it did not exist: $_file');
      await save();
      return;
    }
    _config = jsonDecode(await file.readAsString());

    host = _config['host'];
    port = _config['port'];
    mongoHost = _config['mongoHost'];
    mongoPort = _config['mongoPort'];
    monogoURI = _config['mongoURI'];
    currentForm = _config['currentForm'];
  }

  static save() async {
    await file.writeAsString(jsonEncode({
      'host': host,
      'port': port,
      'mongoHost': mongoHost,
      'mongoPort': mongoPort,
      'mongoURI': monogoURI,
      'currentForm': currentForm
    }));
  }
}