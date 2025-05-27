import 'dart:isolate';
import 'models/home_model.dart';

class HomeParseMessage {
  final SendPort sendPort;
  final List<dynamic> jsonData;

  HomeParseMessage(this.sendPort, this.jsonData);
}

void homeModelIsolateEntry(HomeParseMessage message) {
  final List<HomeModel> result = message.jsonData
      .map((item) => HomeModel.fromJson(item))
      .toList();
  message.sendPort.send(result);
}
