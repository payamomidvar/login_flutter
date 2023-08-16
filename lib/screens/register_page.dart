import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/register_bloc.dart';
import '../constants/constants.dart';
import '../models/register.dart';
import '../widgets/username.dart';
import '../widgets/email.dart';
import '../widgets/password.dart';
import '../widgets/submit.dart';
import '../widgets/app_bar.dart' as app_bar;

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController emailController = TextEditingController(),
      usernameController = TextEditingController(),
      passwordController = TextEditingController(),
      repeatPasswordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: app_bar.AppBar(
          onTap: (){
            print('back');
          },
          title: 'Register',
          subtitle: 'Create your account',
          height: MediaQuery.of(context).size.height * 0.3,
        )
          ,
        body: Center(
          child: Form(
            key: formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                Email(controller: emailController),
                Username(controller: usernameController),
                Password(label: 'Password', controller: passwordController),
                Password(
                  label: 'Repeat password',
                  controller: repeatPasswordController,
                  anotherController: passwordController,
                  isRepeatPassword: true,
                ),
                BlocConsumer<RegisterBloc, RegisterState>(
                  listener: (context, state) {
                    if (state.status == RegisterStatus.error ||
                        state.status == RegisterStatus.fail) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage)),
                      );
                    } else if (state.status == RegisterStatus.success) {
                      print('success');
                    }
                  },
                  builder: (context, state) => Submit(
                    isLoading:
                        state.status == RegisterStatus.loading ? true : false,
                    title: 'Register',
                    onTap: () => onSubmitTap(context),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('I have an account?'),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        minimumSize: const Size(largeWidth, mediumHeight),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Login',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Theme.of(context).primaryColor),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onSubmitTap(BuildContext context) async {
    if (formKey.currentState?.validate() ?? false ) {
      String? username = usernameController.text.isEmpty?null : usernameController.text;
      final Register dto = Register(
        email: emailController.text,
        username: username,
        password: passwordController.text,
        repeatPassword: repeatPasswordController.text,
      );
      context.read<RegisterBloc>().add(RegisterEvent(dto));
    }
  }
}
