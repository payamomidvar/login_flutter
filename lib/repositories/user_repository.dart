import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:login/models/login.dart';
import './config.dart';
import '../models/register.dart';
import '../constants/constants.dart';

class UserRepository {
  Future<bool> register(final Register dto) async {
    bool result = false;
    Uri url = Uri(scheme: scheme, host: host, port: port, path: 'register/');
    await http
        .post(url, headers: headers, body: json.encode(dto.toJson()))
        .timeout(duration)
        .then((response) {
      if (response.statusCode != 201) {
        throw HttpException('${response.statusCode}');
      }
      result = true;
    }).onError((error, stackTrace) {
      throw Exception(error);
    });

    return result;
  }

  Future<String?> login(final Login dto) async {
    String? token;
    Uri url = Uri(
      scheme: scheme,
      host: host,
      port: port,
      path: 'login/',
    );
    await http
        .post(url, headers: headers, body: json.encode(dto.toJson()))
        .timeout(duration)
        .then((response) {
      print(response.statusCode);
      if (response.statusCode != 200) {
        throw HttpException('${response.statusCode}');
      }
      final res = jsonDecode(response.body);
      token = res['access'];
    }).onError((error, stackTrace) {
      throw Exception(error);
    });

    return token;
  }
}
