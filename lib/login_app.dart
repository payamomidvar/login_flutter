import 'package:flutter/material.dart';
import 'package:login/screens/register_page.dart';
import './themes/light_theme.dart';
import 'bloc/register.dart';

class LoginApp extends StatelessWidget {
  const LoginApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: const Register(),
    );
  }
}
