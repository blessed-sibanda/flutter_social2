enum EmailAction { resendConfirmation, resetPassword }

class SignInData {
  final String email;
  final String password;

  SignInData({
    required this.email,
    required this.password,
  });

  Map<String, String> toJson() => {
        'email': email,
        'password': password,
      };
}

class SignUpData {
  final String name;
  final String email;
  final String password;

  SignUpData({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, String> toJson() => {
        'name': name,
        'email': email,
        'password': password,
      };
}

class EmailData {
  final String email;

  EmailData({required this.email});

  Map<String, String> toJson() => {'email': email};
}

class ResetPasswordData {
  final String resetPasswordToken;
  final String password;
  final String passwordConfirmation;

  ResetPasswordData({
    required this.resetPasswordToken,
    required this.password,
    required this.passwordConfirmation,
  });

  Map<String, String> toJson() => {
        'reset_password_token': resetPasswordToken,
        'password': password,
        'password_confirmation': passwordConfirmation,
      };
}
