import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/constants.dart';
import '../routes/routes.dart';
import '../bloc/token/token_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    _loadMemory();
  }

  Future<void> _loadMemory() async {
    await Future.delayed(startTime).then((value) async {
      BlocProvider.of<TokenBloc>(context).add(const TokenEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener<TokenBloc, TokenState>(
          listener: (_, state) {
            if (state.token != null) {
              Navigator.pushNamed(context, RouteApp.home);
            } else {
              Navigator.pushNamed(context, RouteApp.login);
            }
          },
          child: Center(child: _buildBody),
        ),
      ),
    );
  }

  Widget get _buildBody {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(largePadding),
          child: Text(
            appName,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: primaryColor),
          ),
        ),
        const SizedBox(
          height: mediumWidth,
          width: mediumHeight,
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}
