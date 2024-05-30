abstract class LoginState {
  final String message;
  LoginState(this.message);
}

class LoginSuccess extends LoginState {
  LoginSuccess(): super('');
}

class LoginLoading extends LoginState {
  LoginLoading(): super('');
}

class LoginFailed extends LoginState {
  LoginFailed(super.message);
}

class LoginEmailError extends LoginState {
  LoginEmailError(super.message);
}

class LoginPasswordError extends LoginState {
  LoginPasswordError(super.message);
}