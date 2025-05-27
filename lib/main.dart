import 'dart:io';

import 'package:flutter/material.dart';

import 'app.dart';
import 'core/di.dart';
import 'core/network/dio_factory.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid&&Platform.isIOS) {
    HttpOverrides.global = MyHttpOverrides();
  }
  await setupGetIt();
  await DioFactory.init();
  runApp(const MyApp());
}



class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
