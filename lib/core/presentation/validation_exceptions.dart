class LoginValidateException implements Exception {
  final String message;
  LoginValidateException(this.message);
}

class PasswordValidateException implements Exception {
  final String message;
  PasswordValidateException(this.message);
}
