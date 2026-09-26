class Validators {
  Validators._();

  static final RegExp _emailRegex =
      RegExp(r"^[\w\.\-+]+@[\w\-]+\.[a-zA-Z]{2,}$");

  static String? fullName(String value) {
    if (value.trim().isEmpty) {
      return 'Please enter your full name';
    }

    if (value.trim().length < 2) {
      return 'Enter a valid name';
    }

    return null;
  }

  static String? email(String value) {
    if (value.trim().isEmpty) {
      return 'Please enter your email';
    }

    if (!_emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }

    return null;
  }

  static String? loginIdentifier(String value) {
    if (value.trim().isEmpty) {
      return 'Please enter your email or username';
    }

    return null;
  }

  static String? passwordForSignUp(String value) {
    if (value.isEmpty) {
      return 'Please enter a password';
    }

    return null;
  }

  static String? passwordForLogin(String value) {
    if (value.isEmpty) {
      return 'Please enter your password';
    }

    return null;
  }

  static String? confirmPassword(
    String password,
    String confirm,
  ) {
    if (confirm.isEmpty) {
      return 'Please confirm your password';
    }

    if (password != confirm) {
      return 'Passwords do not match';
    }

    return null;
  }
}
