
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/auth_header.dart';
import '../widgets/mascot.dart';
import '../widgets/rounded_text_field.dart';
import '../widgets/primary_button.dart';
import '../utils/validators.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final identifier = TextEditingController();
  final password = TextEditingController();

  String? identifierError;
  String? passwordError;
  bool loading = false;

  @override
  void dispose() {
    identifier.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> submit() async {
    FocusScope.of(context).unfocus();

    final e = Validators.loginIdentifier(identifier.text);
    final p = Validators.passwordForLogin(password.text);

    setState(() {
      identifierError = e;
      passwordError = p;
    });

    if (e != null || p != null) return;

    setState(() => loading = true);

    // This laboratory focuses on routes and navigation.
    // Login does not require a previous Sign-Up.
    await Future.delayed(const Duration(milliseconds: 200));

    if (!mounted) return;

    // If the user enters an email, display only the part
    // before the @ symbol on the Home screen.
    //
    // Examples:
    // jmfabiala@gmail.com -> jmfabiala
    // jm@gmail.com        -> jm
    //
    // If the user enters a username/full name, display it as-is.
    //
    // Examples:
    // jm                   -> jm
    // jm fabiala           -> jm fabiala
    // Juan Dela Cruz       -> Juan Dela Cruz
    final input = identifier.text.trim();

    final displayName = input.contains('@')
        ? input.split('@').first
        : input;

    Navigator.pushReplacementNamed(
      context,
      '/home',
      arguments: HomeArguments(name: displayName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthPageFrame(
      pose: MascotPose.login,
      onBack: () => Navigator.maybePop(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Welcome back!',
            textAlign: TextAlign.center,
            style: AppText.heading,
          ),
          const SizedBox(height: 4),
          Text(
            'Log in to continue learning.',
            textAlign: TextAlign.center,
            style: AppText.subheading,
          ),
          const SizedBox(height: 18),

          RoundedTextField(
            label: 'Email / Username',
            hint: 'you@example.com or username',
            controller: identifier,
            icon: Icons.person_outline_rounded,
            keyboardType: TextInputType.emailAddress,
            errorText: identifierError,
            onChanged: (_) {
              if (identifierError != null) {
                setState(() => identifierError = null);
              }
            },
          ),
          const SizedBox(height: 10),

          RoundedTextField(
            label: 'Password',
            hint: 'Enter your password',
            controller: password,
            icon: Icons.lock_outline_rounded,
            isPassword: true,
            errorText: passwordError,
            onChanged: (_) {
              if (passwordError != null) {
                setState(() => passwordError = null);
              }
            },
          ),

          const SizedBox(height: 12),

          PrimaryButton(
            label: 'Sign in',
            isLoading: loading,
            onPressed: submit,
          ),

          const SizedBox(height: 18),

          Center(
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/signup'),
              child: Text.rich(
                TextSpan(
                  style: AppText.footer.copyWith(fontSize: 13.5),
                  children: [
                    TextSpan(
                      text: 'Don’t have an account?  ',
                      style: AppText.footer.copyWith(fontSize: 13.5),
                    ),
                    TextSpan(
                      text: 'Sign up',
                      style: AppText.footerLink.copyWith(fontSize: 15.5),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
