import 'package:flutter/material.dart';
import '../constants/constants.dart';

class Submit extends StatefulWidget {
  final bool isLoading;
  final String title;
  final Function() onTap;
  final EdgeInsets? margin;

  const Submit({
    required this.isLoading,
    required this.title,
    required this.onTap,
    this.margin,
    super.key,
  });

  @override
  State<Submit> createState() => _SubmitState();
}

class _SubmitState extends State<Submit> {
  bool isLoading = false;

  @override
  void didUpdateWidget(covariant Submit oldWidget) {
    isLoading = widget.isLoading;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin ?? const EdgeInsets.all(largePadding),
      child: AbsorbPointer(
        absorbing: widget.isLoading,
        child: ElevatedButton(
          onPressed: widget.onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.title),
              if (widget.isLoading)
                Container(
                  height: mediumHeight,
                  width: mediumWidth,
                  padding: const EdgeInsets.all(smallPadding),
                  child: const CircularProgressIndicator(
                    strokeWidth: strokeWidth,
                  ),
                )
              else
                const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
