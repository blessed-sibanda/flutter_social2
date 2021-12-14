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

class UpdateUserData {
  final String name;
  final String email;
  final String? password;
  final String about;
  final String currentPassword;

  UpdateUserData({
    required this.name,
    required this.email,
    required this.currentPassword,
    required this.about,
    this.password,
  });

  Map<String, String> toJson() {
    final mapData = {
      'name': name,
      'email': email,
      'current_password': currentPassword,
    };
    if (password != null && password!.isNotEmpty) {
      mapData['password'] = password!;
    }
    return mapData;
  }
}

class EmailData {
  final String email;

  EmailData({required this.email});

  Map<String, String> toJson() => {'email': email};
}
