import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screens/register_page.dart';
import '../../repositories/user_repository.dart';
import 'register_bloc.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UserRepository(),
      child: BlocProvider(
        create: (context) => RegisterBloc(context.read<UserRepository>()),
        child: RegisterPage(),
      ),
    );
  }
}