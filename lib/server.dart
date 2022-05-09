import 'package:scoutingapp/components/server/api.dart';
import 'package:shelf_plus/shelf_plus.dart';

void main() async => await shelfRun(API.init);
