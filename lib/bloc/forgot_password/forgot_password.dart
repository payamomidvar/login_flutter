import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screens/forgot_password_page.dart';
import '../../repositories/user_repository.dart';
import 'forgot_password_bloc.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UserRepository(),
      child: BlocProvider(
        create: (context) => ForgotPasswordBloc(context.read<UserRepository>()),
        child: ForgotPasswordPage(),
      ),
    );
  }
}