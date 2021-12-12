class FormValidators {
  static String? userNameField(String? value) {
    if (value == null) return null;
    if (value.isEmpty) {
      return 'Name is required';
    } else if (value.length < 3) {
      return 'Name should be at least 3 characters long';
    }
    return null;
  }

  static String? userEmailField(String? value) {
    if (value == null) return null;
    if (value.isEmpty) {
      return 'Email is required';
    } else if (!value.contains('@') || !value.contains('.')) {
      return 'Provide a valid email address';
    }
    return null;
  }

  static String? userPasswordField(String? value,
      {bool allowBlank = false, String label = 'Password'}) {
    if (value == null) return null;
    if (value.isEmpty) {
      if (allowBlank) return null;
      return '$label is required';
    } else if (value.length < 6) {
      return '$label should be at least 6 characters long';
    }
    return null;
  }
}
