import 'package:flutter/material.dart';
import 'package:login/bloc/home/home.dart';
import 'package:login/bloc/splash/splash.dart';
import './themes/light_theme.dart';
import 'bloc/change_password/change_password.dart';
import 'bloc/forgot_password/forgot_password.dart';
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
      initialRoute: RouteApp.splash,
      routes: {
        RouteApp.register: (context) => const Register(),
        RouteApp.changePassword: (context) =>
            ChangePassword(memoryService: memoryService),
        RouteApp.forgotPassword: (context) => const ForgotPassword(),
        RouteApp.login: (context) => Login(memoryService: memoryService),
        RouteApp.home: (context) => Home(memoryService: memoryService),
        RouteApp.splash: (context) => Splash(memoryService: memoryService),
      },
    );
  }
}
