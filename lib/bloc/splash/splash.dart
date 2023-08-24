import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screens/splash_page.dart';
import '../../services/memory_service.dart';
import '../token/token_bloc.dart';

class Splash extends StatelessWidget {
  final MemoryService memoryService;

  const Splash({required this.memoryService, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TokenBloc(memoryService),
      child: const SplashPage(),
    );
  }
}