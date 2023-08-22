import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/user_repository.dart';
import '../../screens/home_page.dart';
import '../../services/memory_service.dart';
import '../token/token_bloc.dart';
import 'home_bloc.dart';

class Home extends StatelessWidget {
  final MemoryService memoryService;

  const Home({required this.memoryService, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UserRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeBloc(context.read<UserRepository>()),
          ),
          BlocProvider(create: (context) => TokenBloc(memoryService)),
        ],
        child: const HomePage(),
      ),
    );
  }
}
