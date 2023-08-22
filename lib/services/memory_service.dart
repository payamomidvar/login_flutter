import 'package:shared_preferences/shared_preferences.dart';

class MemoryService {
  SharedPreferences prefs;

  MemoryService(this.prefs);

  final String _kToken = 'token';

  Future<bool> saveToken(final String token) async =>
      await prefs.setString(_kToken, token);

  String? get getToken => prefs.getString(_kToken);
}
