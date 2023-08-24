import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/bloc/home/home_bloc.dart';
import 'package:login/bloc/token/token_bloc.dart';
import '../repositories/config.dart';
import '../routes/routes.dart';
import '../widgets/app_bar.dart' as app_bar;
import '../constants/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<TokenBloc>(context).add(const TokenEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: !isLoading
            ? app_bar.AppBar(
                icon: Icons.logout,
                onTap: () {},
                subtitle: 'Welcome to login app',
                height: MediaQuery.of(context).size.height * 0.2,
              )
            : null,
        floatingActionButton: !isLoading
            ? FloatingActionButton(
                child: const Icon(Icons.key, color: textColor),
                onPressed: () {
                  Navigator.pushNamed(context, RouteApp.changePassword);
                },
              )
            : null,
        body: Center(
          child: BlocConsumer<TokenBloc, TokenState>(
            listener: (context, state) {
              if (state.token != null) {
                Token.token = state.token!;
                BlocProvider.of<HomeBloc>(context).add(const HomeEvent());
                setState(() {
                  isLoading = false;
                });
              }
            },
            builder: (context, state) {
              return isLoading
                  ? const SizedBox(
                      height: mediumWidth,
                      width: mediumHeight,
                      child: CircularProgressIndicator(),
                    )
                  : BlocConsumer<HomeBloc, HomeState>(
                      listener: (context, state) {
                        if (state.status == HomeStatus.error ||
                            state.status == HomeStatus.fail) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.errorMessage)),
                          );
                        } else if (state.status == HomeStatus.fail) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('try again...')),
                          );
                        }
                      },
                      builder: (context, state) {
                        state.status == HomeStatus.error;
                        return Center(
                          child: state.status == HomeStatus.initial ||
                                  state.status == HomeStatus.loading
                              ? const SizedBox(
                                  height: mediumWidth,
                                  width: mediumHeight,
                                  child: CircularProgressIndicator(),
                                )
                              : state.status == HomeStatus.success
                                  ? Text('Hi ${state.user?.username ?? ''}')
                                  : IconButton(
                                      onPressed: () {
                                        context
                                            .read<HomeBloc>()
                                            .add(const HomeEvent());
                                      },
                                      icon: const Icon(Icons.replay),
                                    ),
                        );
                      },
                    );
            },
          ),
        ),
      ),
    );
  }
}
