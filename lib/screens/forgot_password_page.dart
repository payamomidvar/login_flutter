import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/bloc/forgot_password/forgot_password_bloc.dart';
import '../constants/constants.dart';
import '../models/forgot_password.dart';
import '../widgets/email.dart';
import '../widgets/submit.dart';
import '../widgets/app_bar.dart' as app_bar;

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: app_bar.AppBar(
          onTap: () => Navigator.pop(context),
          icon: Icons.arrow_back,
          title: 'Forgot password',
          subtitle: 'Enter your email account to reset password',
          height: MediaQuery.of(context).size.height * 0.2,
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: largePadding),
            child: ListView(
              shrinkWrap: true,
              children: [
                Email(controller: emailController),
                BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
                  listener: (context, state) {
                    if (state.status == ForgotPasswordStatus.error ||
                        state.status == ForgotPasswordStatus.fail) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage)),
                      );
                    } else if (state.status == ForgotPasswordStatus.success) {
                      showSuccessMessage(context);
                    }
                  },
                  builder: (context, state) => Submit(
                    isLoading: state.status == ForgotPasswordStatus.loading
                        ? true
                        : false,
                    title: 'Submit',
                    onTap: () => onSubmitTap(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onSubmitTap(BuildContext context) async {
    if (formKey.currentState?.validate() ?? false) {
      final ForgotPassword dto = ForgotPassword(
        email: emailController.text,
      );
      context.read<ForgotPasswordBloc>().add(ForgotPasswordEvent(dto));
    }
  }

  showSuccessMessage(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () => Navigator.pop(context),
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Success"),
      content: const Text("New password was send your email, please login."),
      actions: [okButton],
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => alert,
    ).then((value) {
      Navigator.pop(context);
    });
  }
}
