import 'dart:io';

import 'package:shelf_plus/shelf_plus.dart';

import 'package:scoutingapp/components/server/api.dart';
import 'package:scoutingapp/components/server/config.dart';

void main(List<String> args) async {
  stdout.writeln("ScoutingApp data server");
  await ServerConfig.loadFrom('config.json');

  await API.initMongo();

  await shelfRun(API.init,
      defaultBindAddress: ServerConfig.host,
      defaultBindPort: ServerConfig.port,
      defaultEnableHotReload: false);
}
