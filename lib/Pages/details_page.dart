import 'dart:convert';

import 'package:coinpp/models/app_config.dart';
import 'package:coinpp/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class DetailsPage extends StatefulWidget {
  String? data;
  Map exchanges;
  DetailsPage({required this.data, required this.exchanges, super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  HTTPService? _http;
  AppConfig? _appConfig;
  @override
  void initState() {
    super.initState();
    _http = GetIt.instance.get<HTTPService>();
    print(_http);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prices'),
      ),
      body: DataBuild(),
    );
  }

  Widget DataBuild() {
    return FutureBuilder(
        future: _http!.get('/coins/${widget.data}'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Map data = jsonDecode(snapshot.data.toString());
            Map curency = data["market_data"]["current_price"];
            List<MapEntry<dynamic, dynamic>> entriesList =
                widget.exchanges.entries.toList();
            print(entriesList);
            //  print(curency);
            return Scaffold(
              body: SafeArea(
                child: (ListView.builder(
                  itemCount: entriesList.length,
                  itemBuilder: (context, index) {
                    final item = entriesList[index];
                    print(item.key);

                    return ListTile(
                      title: Text('${item.key.toString().toUpperCase()} :${item.value.toString()}'),
                      textColor: Colors.white,
                    );
                  },
                )),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
