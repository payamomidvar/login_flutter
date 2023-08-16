import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import './config.dart';
import '../models/register.dart';
import '../constants/constants.dart';
import 'package:dio/dio.dart';

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
}
