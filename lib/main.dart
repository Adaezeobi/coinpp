import 'dart:convert';

import 'package:coinpp/Pages/home.dart';
import 'package:coinpp/models/app_config.dart';
import 'package:coinpp/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadConfig();
  registerHTTPService();
 // await GetIt.instance.get<HTTPService>().get("/coins/bitcoin");
  runApp(const MyApp());
}

Future<void> loadConfig() async {
//String _configContent = a
  String _configContent =
      await rootBundle.loadString("assets/config/main.json");
  Map _configData = jsonDecode(_configContent);
  //GetIt.instance
  print(_configData);
  GetIt.instance.registerSingleton<AppConfig>(
      AppConfig(COIN_API_BASE_URL: _configData["COIN_API_URL"]));
}

void registerHTTPService() {
  GetIt.instance.registerSingleton<HTTPService>(
    HTTPService(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CoinApp',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a blue toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Color.fromRGBO(88, 60, 197, 1.0)),
      home: home_page(),
    );
  }
}
