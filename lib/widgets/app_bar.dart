import 'dart:math';

import 'package:flutter/material.dart';

import '../constants/constants.dart';

class AppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final double height;
  final Function()? onTap;

  const AppBar({
    required this.title,
    required this.subtitle,
    this.height = kToolbarHeight,
    this.onTap,
    super.key,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFF1F2D3B),
      child: Stack(
        children: [
          shape1(),
          shape2(),
          Positioned(
            bottom: 70,
            left: 30,
            child: Text(
              title,
              style: const TextStyle(
                  color: secondaryColor, fontSize: hugeFontSize),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 30,
            child: Text(
              subtitle,
              style: const TextStyle(
                  color: descriptionColor, fontSize: largeFontSize),
            ),
          ),
          onTap != null
              ? Positioned(
                  top: 20,
                  left: 10,
                  child: IconButton(
                    onPressed: onTap,
                    icon: const Icon(Icons.arrow_back, color: secondaryColor),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget shape1() {
    return Container(
      height: preferredSize.height,
      color: Colors.transparent,
      child: ClipPath(
        clipper: CurvedBottomClipper(
          left: -200,
          bottomCoefficient: 0.7,
          rightCoefficient: 0.7,
          roundingHeightCoefficient: 2.5,
        ),
        child: Container(
          color: const Color(0xFF162534),
        ),
      ),
    );
  }

  Widget shape2() {
    return Container(
      height: preferredSize.height,
      color: Colors.transparent,
      child: ClipPath(
        clipper: CurvedBottomClipper(
          left: -300,
          bottomCoefficient: 1,
          rightCoefficient: 0.9,
          roundingHeightCoefficient: 3,
        ),
        child: Container(
          color: const Color(0xFF0C1C2C),
        ),
      ),
    );
  }
}

class CurvedBottomClipper extends CustomClipper<Path> {
  final double left;
  final double rightCoefficient;
  final double bottomCoefficient;
  final double roundingHeightCoefficient;

  CurvedBottomClipper({
    required this.left,
    required this.rightCoefficient,
    required this.bottomCoefficient,
    required this.roundingHeightCoefficient,
  });

  @override
  Path getClip(Size size) {
    final roundingHeight = size.width * 3 / 5;

    final filledRectangle = Rect.fromLTRB(0, 0, size.width, size.height);

    final roundingRectangle = Rect.fromLTRB(
      left,
      size.height - roundingHeight * roundingHeightCoefficient,
      size.width * rightCoefficient,
      size.height * bottomCoefficient,
    );

    final path = Path();
    path.addRect(filledRectangle);

    path.arcTo(roundingRectangle, pi, -pi, true);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
