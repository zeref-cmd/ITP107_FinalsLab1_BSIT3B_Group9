
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'mascot.dart';

class AuthPageFrame extends StatelessWidget {
  final MascotPose pose;
  final VoidCallback? onBack;
  final Widget child;

  const AuthPageFrame({
    super.key,
    required this.pose,
    required this.child,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 380;
            final headerHeight = compact ? 355.0 : 390.0;
            final mascotWidth = compact ? 245.0 : 285.0;

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      AuthHeader(
                        pose: pose,
                        height: headerHeight,
                        mascotWidth: mascotWidth,
                      ),
                      Transform.translate(
                        offset: const Offset(0, -72),
                        child: AuthCreamPanel(child: child),
                      ),
                      const SizedBox(height: 1),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class AuthHeader extends StatelessWidget {
  final MascotPose pose;
  final VoidCallback? onBack;
  final double height;
  final double mascotWidth;

  const AuthHeader({
    super.key,
    required this.pose,
    this.onBack,
    this.height = 390,
    this.mascotWidth = 285,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ClipRect(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/auth_background.png',
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),

            // Back button removed.
            
            Positioned(
              top: 76,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Text(
                    'Worly',
                    style: AppText.logo,
                  ),
                  const SizedBox(height: 7),
                  Text(
                    'Learn new words easily',
                    style: AppText.topSubtitle,
                  ),
                  const SizedBox(height: 15),
                  Mascot(
                    pose: pose,
                    width: mascotWidth,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthCreamPanel extends StatelessWidget {
  final Widget child;

  const AuthCreamPanel({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _CreamWaveClipper(),
      child: Container(
        width: double.infinity,
        color: AppColors.cream,
        padding: const EdgeInsets.fromLTRB(24, 78, 24, 30),
        child: child,
      ),
    );
  }
}

class _CreamWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(0, 48);
    path.cubicTo(
      size.width * .13,
      77,
      size.width * .26,
      70,
      size.width * .39,
      38,
    );
    path.cubicTo(
      size.width * .52,
      6,
      size.width * .64,
      8,
      size.width * .76,
      41,
    );
    path.cubicTo(
      size.width * .87,
      70,
      size.width * .94,
      75,
      size.width,
      51,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant _CreamWaveClipper oldClipper) => false;
}
