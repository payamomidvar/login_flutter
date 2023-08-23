import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screens/change_password_page.dart';
import '../../repositories/user_repository.dart';
import 'change_password_bloc.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UserRepository(),
      child: BlocProvider(
        create: (context) => ChangePasswordBloc(context.read<UserRepository>()),
        child: ChangePasswordPage(),
      ),
    );
  }
}