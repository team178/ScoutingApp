import 'package:shelf_plus/shelf_plus.dart';

void main() => shelfRun(init);

Handler init() {
  var app = Router().plus;

  app.post('/sync', (Request request) async {
    var data = await request.body.asJson;
    return data;
  });

  return app;
}