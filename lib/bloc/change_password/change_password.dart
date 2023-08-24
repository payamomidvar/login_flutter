import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screens/change_password_page.dart';
import '../../repositories/user_repository.dart';
import '../../services/memory_service.dart';
import '../logout/logout_bloc.dart';
import 'change_password_bloc.dart';

class ChangePassword extends StatelessWidget {
  final MemoryService memoryService;

  const ChangePassword({required this.memoryService, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UserRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                ChangePasswordBloc(context.read<UserRepository>()),
          ),
          BlocProvider(create: (context) => LogoutBloc(memoryService)),
        ],
        child: ChangePasswordPage(),
      ),
    );
  }
}
