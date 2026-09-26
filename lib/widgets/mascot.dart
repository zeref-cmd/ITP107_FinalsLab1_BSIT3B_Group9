import 'package:flutter/material.dart';

enum MascotPose { signup, login }

class Mascot extends StatelessWidget {
  final MascotPose pose;
  final double width;
  const Mascot({super.key, required this.pose, this.width = 285});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      pose == MascotPose.signup
          ? 'assets/images/mascot_signup_exact.png'
          : 'assets/images/mascot_login_exact.png',
      width: width,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
    );
  }
}
