import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../utils/validator.dart';

class Email extends StatelessWidget {
  final TextEditingController controller;
  final EdgeInsets? margin;

  const Email({
    required this.controller,
    this.margin,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ??
          const EdgeInsets.symmetric(
            horizontal: largePadding,
            vertical: smallPadding,
          ),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == "" || value == null) {
            return 'Email is required';
          }
          else if (!value.isValidEmail()) {
            return 'Check your email';
          }
          return null;
        },
        decoration: const InputDecoration(
          hintText: 'Email',
          label: Text('Email'),
        ),
      ),
    );
  }
}
