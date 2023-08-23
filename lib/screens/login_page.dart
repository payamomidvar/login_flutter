import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/models/login.dart';
import 'package:login/widgets/email.dart';
import 'package:login/widgets/password.dart';
import '../bloc/login/login_bloc.dart';
import '../bloc/login/login_memory_bloc.dart';
import '../constants/constants.dart';
import '../routes/routes.dart';
import '../widgets/app_bar.dart' as app_bar;
import '../widgets/submit.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: app_bar.AppBar(
          title: 'Sign in to your account',
          subtitle: 'Sign in to your account',
          height: MediaQuery.of(context).size.height * 0.3,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: largePadding),
          child: Form(
            key: formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                Email(controller: emailController),
                Password(controller: passwordController, label: 'Password'),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: largePadding,
                    vertical: smallPadding,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          minimumSize: const Size(largeWidth, mediumHeight),
                        ),
                        onPressed: () => Navigator.pushNamed(
                            context, RouteApp.forgotPassword),
                        child: Text(
                          'Forgot password?',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Theme.of(context).primaryColor),
                        ),
                      )
                    ],
                  ),
                ),
                BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state.status == LoginStatus.error ||
                        state.status == LoginStatus.fail) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage)),
                      );
                    } else if (state.status == LoginStatus.success) {
                      if (state.token != null) {
                        BlocProvider.of<LoginMemoryBloc>(context)
                            .saveToken(state.token!);
                        Navigator.pushNamed(context, RouteApp.home);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('try again...')),
                        );
                      }
                    }
                  },
                  builder: (context, state) => Submit(
                    isLoading:
                        state.status == LoginStatus.loading ? true : false,
                    title: 'Login',
                    onTap: () => onSubmitTap(context),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        minimumSize: const Size(largeWidth, mediumHeight),
                      ),
                      onPressed: () =>
                          Navigator.pushNamed(context, RouteApp.register),
                      child: Text(
                        'Register',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Theme.of(context).primaryColor),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onSubmitTap(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      final Login dto = Login(
        email: emailController.text,
        password: passwordController.text,
      );
      context.read<LoginBloc>().add(LoginEvent(dto));
    }
  }
}
