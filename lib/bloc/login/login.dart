import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/bloc/login/login_memory_bloc.dart';

import '../../screens/login_page.dart';
import '../../repositories/user_repository.dart';
import '../../services/memory_service.dart';
import 'login_bloc.dart';

class Login extends StatelessWidget {
  final MemoryService memoryService;

  const Login({required this.memoryService, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UserRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginBloc(context.read<UserRepository>()),
          ),
          BlocProvider(create: (context) => LoginMemoryBloc(memoryService)),
        ],
        child: LoginPage(),
      ),
    );
  }
}
