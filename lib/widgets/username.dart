import 'package:flutter/material.dart';
import '../constants/constants.dart';

class Username extends StatelessWidget {
  final TextEditingController controller;
  final EdgeInsets? margin;

  const Username({
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
        decoration: const InputDecoration(
          hintText: 'Username',
          label: Text('Username'),
        ),
      ),
    );
  }
}
