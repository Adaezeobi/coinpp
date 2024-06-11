import 'package:coinpp/models/app_config.dart';
import 'package:dio/dio.dart';

import 'package:get_it/get_it.dart';

class HTTPService {
  final Dio dio = Dio();

  AppConfig? _appConfig;
  String? _base_url;

  HTTPService() {
    _appConfig = GetIt.instance.get<AppConfig>();
    _base_url = _appConfig!.COIN_API_BASE_URL;
  }

  Future<Response?> get(String _path) async {

    try {
      String _url = "${_base_url}${_path}";
      Response response = await dio.get(_url);
      print(response);
      return response;
    } catch (e) {
      print(e);
    }
  }
Future<Response?> post(String _path,{dynamic body=const {}}) async {
    try {
      String _url = "${_base_url}${_path}";
      Response response = await dio.post(_url,data: body);
      print(response);
      return response;
    } catch (e) {
      print(e);
    }
  }

  Future<Response?> delete(String _path,{dynamic body=const {},Map<String, dynamic>? queryParameters,}) async {
    try {
      String _url = "${_base_url}${_path}";
      Response response = await dio.delete(_url,data: body,queryParameters: queryParameters);
      print(response);
      return response;
    } catch (e) {
      print(e);
    }
  }

    Future<Response?> put(String _path,{dynamic body=const {},Map<String, dynamic>? queryParameters,}) async {
    try {
      String _url = "${_base_url}${_path}";
      Response response = await dio.put(_url,data: body,queryParameters: queryParameters);
      print(response);
      return response;
    } catch (e) {
      print(e);
    }
  }
}

