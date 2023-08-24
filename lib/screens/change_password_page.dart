import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/bloc/change_password/change_password_bloc.dart';
import 'package:login/models/change_password.dart';
import 'package:login/repositories/config.dart';
import '../bloc/logout/logout_bloc.dart';
import '../constants/constants.dart';
import '../routes/routes.dart';
import '../widgets/password.dart';
import '../widgets/submit.dart';
import '../widgets/app_bar.dart' as app_bar;

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  late LogoutBloc logoutBloc;

  final TextEditingController currentPasswordController =
          TextEditingController(),
      newPasswordController = TextEditingController(),
      repeatNewPasswordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    logoutBloc = BlocProvider.of<LogoutBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: app_bar.AppBar(
          onTap: () => Navigator.pop(context),
          icon: Icons.arrow_back,
          title: 'Change password',
          subtitle: 'Enter current password and new password',
          height: MediaQuery.of(context).size.height * 0.2,
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: largePadding),
            child: ListView(
              shrinkWrap: true,
              children: [
                Password(
                    label: 'Current password',
                    controller: currentPasswordController),
                Password(
                    label: 'New password', controller: newPasswordController),
                Password(
                  label: 'Repeat new password',
                  controller: repeatNewPasswordController,
                  anotherController: newPasswordController,
                  isRepeatPassword: true,
                ),
                BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
                  listener: (context, state) {
                    if (state.status == ChangePasswordStatus.error ||
                        state.status == ChangePasswordStatus.fail) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage)),
                      );
                    } else if (state.status == ChangePasswordStatus.success) {
                      showSuccessMessage(context);
                    }
                  },
                  builder: (context, state) => Submit(
                    isLoading: state.status == ChangePasswordStatus.loading
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
      final ChangePassword dto = ChangePassword(
        currentPassword: currentPasswordController.text,
        newPassword: newPasswordController.text,
        repeatNewPassword: repeatNewPasswordController.text,
      );
      context.read<ChangePasswordBloc>().add(ChangePasswordEvent(dto));
    }
  }

  showSuccessMessage(BuildContext context) {

    AlertDialog alert = AlertDialog(
      title: const Text("Success"),
      content: const Text("Password changed, please login again."),
      actions: [
        BlocConsumer(
          bloc: logoutBloc,
          listener: (context, bool state) {
            if (state) {
              Token.token = '';
              Navigator.pushNamed(context, RouteApp.login);
            }
          },
          builder: (context, state) =>  TextButton(
            child: const Text("OK"),
            onPressed: () => logoutBloc.logout(),
          ),
        )
      ],
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => alert,
    );
  }
}
