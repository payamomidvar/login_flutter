import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screens/login_page.dart';
import '../../repositories/user_repository.dart';
import 'login_bloc.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UserRepository(),
      child: BlocProvider(
        create: (context) => LoginBloc(context.read<UserRepository>()),
        child: LoginPage(),
      ),
    );
  }
}