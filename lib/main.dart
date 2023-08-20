import 'package:flutter/cupertino.dart';
import 'package:login/login_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'services/memory_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  final MemoryService memoryService = MemoryService(preferences);
  runApp(LoginApp(memoryService: memoryService));
}
