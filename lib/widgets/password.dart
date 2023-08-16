import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../utils/validator.dart';

class Password extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final EdgeInsets? margin;
  bool isRepeatPassword;
  TextEditingController? anotherController;

  Password({
    required this.controller,
    required this.label,
    this.margin,
    this.isRepeatPassword = false,
    this.anotherController,
    super.key,
  }) {
    if (isRepeatPassword && anotherController == null) {
      throw Exception(
          'If isRepeatPassword is true then anotherController is required');
    }
  }

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin ??
          const EdgeInsets.symmetric(
            horizontal: largePadding,
            vertical: smallPadding,
          ),
      child: TextFormField(
        controller: widget.controller,
        obscuringCharacter: '*',
        obscureText: obscure,
        validator: (value) {
          if (value == null) {
            return '${widget.label} is required';
          } else if (value.length < 8) {
            return 'The minimum ${widget.label} length must be 8';
          } else if (value.isValidPassword()) {
            return ("${widget.label} should contain upper,lower,digit and Special character ");
          } else if (widget.isRepeatPassword &&
              widget.controller.text != widget.anotherController?.text) {
            return 'password and repeat password are not the same';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: widget.label,
          label: Text(widget.label),
          suffix: GestureDetector(
            onTap: () => setState(() => obscure = !obscure),
            child: const Icon(Icons.remove_red_eye_rounded),
          ),
        ),
      ),
    );
  }
}
