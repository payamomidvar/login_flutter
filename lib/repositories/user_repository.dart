import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:login/models/forgot_password.dart';
import 'package:login/models/login.dart';
import 'package:login/models/user.dart';
import '../models/change_password.dart';
import './config.dart';
import '../models/register.dart';
import '../constants/constants.dart';

class UserRepository {
  Future<bool> register(final Register dto) async {
    bool result = false;
    Uri url = Uri(scheme: scheme, host: host, port: port, path: 'register/');
    await http
        .post(url,
            headers: {'Content-Type': 'application/json'},
            body: json.encode(dto.toJson()))
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
        .post(url,
            headers: {'Content-Type': 'application/json'},
            body: json.encode(dto.toJson()))
        .timeout(duration)
        .then((response) {
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

  Future<User?> getUser() async {
    String token = Token.token;
    User? user;
    Uri url = Uri(
      scheme: scheme,
      host: host,
      port: port,
      path: 'user/',
    );
    await http
        .get(url, headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        })
        .timeout(duration)
        .then((response) {
          if (response.statusCode != 200) {
            throw HttpException('${response.statusCode}');
          }
          final json = jsonDecode(response.body);
          user = User.fromJson(json);
        })
        .onError((error, stackTrace) {
          throw Exception(error);
        });

    return user;
  }

  Future<bool> changePassword(final ChangePassword dto) async {
    String token = Token.token;
    bool result = false;
    Uri url = Uri(
      scheme: scheme,
      host: host,
      port: port,
      path: 'user/change_password/',
    );
    await http
        .patch(url, body: dto.toJson(), headers: {
          'Authorization': 'Bearer $token',
        })
        .timeout(duration)
        .then((response) {
          if (response.statusCode != 200) {
            throw HttpException('${response.statusCode}');
          }
          result = true;
        })
        .onError((error, stackTrace) {
          throw Exception(error);
        });

    return result;
  }

  Future<bool> forgotPassword(final ForgotPassword dto) async {
    bool result = false;
    Uri url = Uri(scheme: scheme, host: host, port: port, path: 'user/forgot_password/');
    await http
        .post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(dto.toJson()))
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
