import 'package:flutter/material.dart';
import 'package:login/screens/login_page.dart';
import 'package:login/screens/register_page.dart';
import './themes/light_theme.dart';
import 'bloc/login/login.dart';
import 'bloc/register/register.dart';
import 'services/memory_service.dart';
import 'routes/routes.dart';

class LoginApp extends StatelessWidget {
  final MemoryService memoryService;

  const LoginApp({required this.memoryService, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      initialRoute: RouteApp.login,
      routes: {
        RouteApp.register: (context) => const Register(),
        RouteApp.login: (context) => Login(memoryService: memoryService),
      },
    );
  }
}
