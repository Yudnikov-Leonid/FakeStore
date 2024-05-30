abstract class LoginEvent {}

class LoginLoginEvent extends LoginEvent {
  final String login;
  final String password;
  LoginLoginEvent(this.login, this.password);
}

class LoginHideErrorsEvent extends LoginEvent {}