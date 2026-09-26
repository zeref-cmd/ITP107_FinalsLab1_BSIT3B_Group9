import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class HomeArguments {
  final String name;

  const HomeArguments({required this.name});
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as HomeArguments?;
    final rawName = args?.name.trim() ?? '';

    // Keep the complete name/username when the user enters a name.
    // Only email addresses are shortened to the first two characters.
    // Examples: "jm fabiala" -> "jm fabiala"
    //           "jm@gmail.com" -> "jm"
    final isEmail = rawName.contains('@');
    final emailName = isEmail ? rawName.split('@').first.trim() : rawName;
    final name = isEmail
        ? (emailName.length > 2 ? emailName.substring(0, 2) : emailName)
        : rawName;

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth > 700;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 760),
                  child: Column(
                    children: [
                      _HeroSection(name: name, wide: wide),
                      _ContentSection(name: name, wide: wide),
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

class _HeroSection extends StatelessWidget {
  final String name;
  final bool wide;

  const _HeroSection({required this.name, required this.wide});

  @override
  Widget build(BuildContext context) {
    // Keep the mascot large enough to match the reference while leaving
    // the Worly title and greeting bubble completely visible.
    final height = wide ? 425.0 : 390.0;
    final mascotHeight = wide ? 295.0 : 275.0;

    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/auth_background.png',
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),

          const _StarsAndClouds(),

          Positioned(
            top: 62,
            left: 18,
            child: _CircleButton(
              icon: Icons.menu_rounded,
              onPressed: () {},
            ),
          ),
          Positioned(
            top: 62,
            right: 18,
            child: _CircleButton(
              icon: Icons.notifications_none_rounded,
              onPressed: () {},
            ),
          ),

          Positioned(
            top: 73,
            left: 70,
            right: 70,
            child: Column(
              children: [
                Text(
                  'Worly',
                  style: AppText.logo.copyWith(
                    fontSize: wide ? 62 : 55,
                  ),
                ),

              ],
            ),
          ),

          // Larger mascot, kept low enough that it never covers the
          // Worly title. The greeting sits to its upper-right.
          Positioned(
            left: wide ? 105 : 28,
            right: wide ? 105 : 38,
            bottom: 2,
            child: SizedBox(
              height: mascotHeight,
              child: Image.asset(
                'assets/images/mascot_home_ai.png',
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),

          Positioned(
            right: wide ? 40 : 8,
            top: wide ? 165 : 155,
            child: _CloudGreeting(
              name: name,
              wide: wide,
            ),
          ),

          Positioned(
            bottom: -60,
            left: -20,
            right: -20,
            child: ClipPath(
              clipper: _AuthWaveClipper(),
              child: Container(
                height: 135,
                color: AppColors.cream,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContentSection extends StatelessWidget {
  final String name;
  final bool wide;

  const _ContentSection({required this.name, required this.wide});

  @override
  Widget build(BuildContext context) {
    final horizontal = wide ? 42.0 : 18.0;

    return Container(
      color: AppColors.cream,
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(horizontal, 0, horizontal, 30),
      child: Column(
        children: [
          Text(
            'Welcome,',
            style: AppText.heading.copyWith(fontSize: wide ? 30 : 27),
          ),
          const SizedBox(height: 2),
          Text(
            '$name!',
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppText.heading.copyWith(
              fontSize: wide ? 43 : 37,
              color: AppColors.purple,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Let's learn something new today!",
            style: AppText.subheading.copyWith(fontSize: wide ? 17 : 14),
          ),
          const SizedBox(height: 18),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Expanded(
                child: _FeatureCard(
                  icon: Icons.menu_book_rounded,
                  title: 'Learn Words',
                  subtitle: 'Discover new words',
                  tint: Color(0xFFF0E7FF),
                  iconBackground: Color(0xFFE4D5FF),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _FeatureCard(
                  icon: Icons.star_rounded,
                  title: 'Favorites',
                  subtitle: 'View your saved words',
                  tint: Color(0xFFFFF2D4),
                  iconBackground: Color(0xFFFFE18A),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _FeatureCard(
                  icon: Icons.bar_chart_rounded,
                  title: 'Progress',
                  subtitle: 'Track your learning',
                  tint: Color(0xFFE8F3FF),
                  iconBackground: Color(0xFFCFE6FF),
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          Row(
            children: [
              Expanded(
                child: Text(
                  'Continue Learning',
                  style: AppText.heading.copyWith(
                    fontSize: wide ? 27 : 24,
                  ),
                ),
              ),
              Text(
                'See all  ›',
                style: AppText.footerLink.copyWith(
                  fontSize: wide ? 15 : 13,
                ),
              ),
            ],
          ),

          const SizedBox(height: 11),

          Row(
            children: const [
              Expanded(
                child: _LearningCard(
                  icon: Icons.menu_book_rounded,
                  title: 'Daily Words',
                  subtitle: '5 words left today',
                  tint: Color(0xFFF0E7FF),
                  iconBackground: Color(0xFFE4D5FF),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _LearningCard(
                  icon: Icons.quiz_rounded,
                  title: 'Word Quiz',
                  subtitle: 'Test your knowledge',
                  tint: Color(0xFFE8F3FF),
                  iconBackground: Color(0xFFCFE6FF),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 58,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: AppColors.buttonGradient,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.purple.withOpacity(.22),
                    blurRadius: 15,
                    offset: const Offset(0, 7),
                  ),
                ],
              ),
              child: TextButton.icon(
                onPressed: () => Navigator.pushReplacementNamed(
                  context,
                  '/login',
                ),
                icon: const Icon(
                  Icons.logout_rounded,
                  color: Colors.white,
                  size: 25,
                ),
                label: Text(
                  'Logout',
                  style: AppText.button.copyWith(fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color tint;
  final Color iconBackground;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.tint,
    required this.iconBackground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 145,
      padding: const EdgeInsets.fromLTRB(12, 12, 10, 12),
      decoration: BoxDecoration(
        color: tint,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(.8)),
        boxShadow: [
          BoxShadow(
            color: AppColors.purple.withOpacity(.08),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _IllustratedIcon(icon: icon, background: iconBackground, size: 52),
          const Spacer(),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppText.label.copyWith(fontSize: 13.5),
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppText.footer.copyWith(fontSize: 11.5),
          ),
        ],
      ),
    );
  }
}

class _LearningCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color tint;
  final Color iconBackground;

  const _LearningCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.tint,
    required this.iconBackground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112,
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
      decoration: BoxDecoration(
        color: tint,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(.8)),
        boxShadow: [
          BoxShadow(
            color: AppColors.purple.withOpacity(.07),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          _IllustratedIcon(icon: icon, background: iconBackground, size: 52),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.label.copyWith(fontSize: 13.5),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.footer.copyWith(fontSize: 11.5),
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          const _ArrowCircle(),
        ],
      ),
    );
  }
}

class _IllustratedIcon extends StatelessWidget {
  final IconData icon;
  final Color background;
  final double size;

  const _IllustratedIcon({
    required this.icon,
    required this.background,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.purple.withOpacity(.10),
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            right: 7,
            top: 7,
            child: Container(
              width: 7,
              height: 7,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Icon(icon, color: AppColors.purple, size: size * .57),
        ],
      ),
    );
  }
}

class _ArrowCircle extends StatelessWidget {
  const _ArrowCircle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.chevron_right_rounded,
        color: AppColors.purple,
        size: 25,
      ),
    );
  }
}

class _CloudGreeting extends StatelessWidget {
  final String name;
  final bool wide;

  const _CloudGreeting({required this.name, required this.wide});

  @override
  Widget build(BuildContext context) {
    final bubbleWidth = wide ? 220.0 : 185.0;
    final bubbleHeight = wide ? 92.0 : 84.0;

    return SizedBox(
      width: bubbleWidth,
      height: bubbleHeight + 18,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            child: Container(
              height: bubbleHeight,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.97),
                borderRadius: BorderRadius.circular(28),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x332B146D),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Hi,\n$name!',
                    textAlign: TextAlign.center,
                    style: AppText.heading.copyWith(
                      fontSize: wide ? 17 : 15,
                      color: AppColors.purple,
                      height: 1.05,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 30,
            bottom: 0,
            child: CustomPaint(
              size: const Size(24, 18),
              painter: _BubbleTailPainter(),
            ),
          ),
        ],
      ),
    );
  }
}

class _BubbleTailPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(.97);
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(5, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _CircleButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(.14),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 46,
          height: 46,
          child: Icon(icon, color: Colors.white, size: 28),
        ),
      ),
    );
  }
}

class _StarsAndClouds extends StatelessWidget {
  const _StarsAndClouds();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          const Positioned(
            left: 42,
            top: 235,
            child: _Cloud(width: 120, height: 58),
          ),
          const Positioned(
            right: 38,
            top: 248,
            child: _Cloud(width: 125, height: 60),
          ),
          const Positioned(
            left: 86,
            top: 186,
            child: _Star(size: 29),
          ),
          const Positioned(
            right: 76,
            top: 215,
            child: _Star(size: 23),
          ),
          const Positioned(
            left: 126,
            top: 302,
            child: _Star(size: 17, dark: true),
          ),
          const Positioned(
            right: 132,
            top: 292,
            child: _Star(size: 19),
          ),
        ],
      ),
    );
  }
}

class _Star extends StatelessWidget {
  final double size;
  final bool dark;

  const _Star({required this.size, this.dark = false});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.star_rounded,
      size: size,
      color: dark ? const Color(0xFF29177C) : const Color(0xFFFFD85A),
    );
  }
}

class _Cloud extends StatelessWidget {
  final double width;
  final double height;

  const _Cloud({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: .72,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xFFD2C4FF),
          borderRadius: BorderRadius.circular(height),
          boxShadow: const [
            BoxShadow(
              color: Color(0x229B84F7),
              blurRadius: 8,
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthWaveClipper extends CustomClipper<Path> {
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
  bool shouldReclip(covariant _AuthWaveClipper oldClipper) => false;
}
