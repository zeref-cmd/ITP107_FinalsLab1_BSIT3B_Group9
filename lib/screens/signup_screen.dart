import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/auth_header.dart';
import '../widgets/mascot.dart';
import '../widgets/rounded_text_field.dart';
import '../widgets/primary_button.dart';
import '../utils/validators.dart';
import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final fullName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  String? nameError;
  String? emailError;
  String? passwordError;
  String? confirmError;
  bool loading = false;

  @override
  void dispose() {
    fullName.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  Future<void> submit() async {
    FocusScope.of(context).unfocus();

    final n = Validators.fullName(fullName.text);
    final e = Validators.email(email.text);
    final p = Validators.passwordForSignUp(password.text);
    final c = Validators.confirmPassword(
      password.text,
      confirmPassword.text,
    );

    setState(() {
      nameError = n;
      emailError = e;
      passwordError = p;
      confirmError = c;
    });

    if (n != null || e != null || p != null || c != null) {
      return;
    }

    setState(() => loading = true);

    await Future.delayed(const Duration(milliseconds: 200));

    if (!mounted) return;

    Navigator.pushReplacementNamed(
      context,
      '/home',
      arguments: HomeArguments(
        name: fullName.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthPageFrame(
      pose: MascotPose.signup,
      onBack: () => Navigator.pop(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Create Account',
            textAlign: TextAlign.center,
            style: AppText.heading,
          ),
          const SizedBox(height: 4),
          Text(
            'Start your learning journey today!',
            textAlign: TextAlign.center,
            style: AppText.subheading,
          ),
          const SizedBox(height: 16),

          RoundedTextField(
            label: 'Full name',
            hint: 'Juan Dela Cruz',
            controller: fullName,
            icon: Icons.person_outline_rounded,
            errorText: nameError,
            onChanged: (_) {
              if (nameError != null) {
                setState(() => nameError = null);
              }
            },
          ),
          const SizedBox(height: 9),

          RoundedTextField(
            label: 'E-mail',
            hint: 'you@example.com',
            controller: email,
            icon: Icons.mail_outline_rounded,
            keyboardType: TextInputType.emailAddress,
            errorText: emailError,
            onChanged: (_) {
              if (emailError != null) {
                setState(() => emailError = null);
              }
            },
          ),
          const SizedBox(height: 9),

          RoundedTextField(
            label: 'Password',
            hint: 'Create a password',
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
          const SizedBox(height: 9),

          RoundedTextField(
            label: 'Confirm password',
            hint: 'Re-enter your password',
            controller: confirmPassword,
            icon: Icons.lock_reset_rounded,
            isPassword: true,
            errorText: confirmError,
            onChanged: (_) {
              if (confirmError != null) {
                setState(() => confirmError = null);
              }
            },
          ),

          const SizedBox(height: 11),

          PrimaryButton(
            label: 'Sign up',
            isLoading: loading,
            onPressed: submit,
          ),

          const SizedBox(height: 18),

          Center(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Text.rich(
                TextSpan(
                  style: AppText.footer.copyWith(fontSize: 13.5),
                  children: [
                    TextSpan(
                      text: 'Already have an account?  ',
                      style: AppText.footer.copyWith(fontSize: 13.5),
                    ),
                    TextSpan(
                      text: 'Sign in',
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

