abstract class LoginResult {
  final String message;
  LoginResult(this.message);
}

class LoginSuccessResult extends LoginResult {
  LoginSuccessResult(): super('');
}

class LoginLoginFail extends LoginResult {
  LoginLoginFail(super.message);
}

class LoginPasswordFail extends LoginResult {
  LoginPasswordFail(super.message);
}

class LoginFail extends LoginResult {
  LoginFail(super.message);
}
