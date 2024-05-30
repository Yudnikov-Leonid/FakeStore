import 'package:email_validator/email_validator.dart';
import 'package:fake_store/core/presentation/validation_exceptions.dart';

abstract class UiValidator {
  void isValid(String value);
}

class LoginUiValidator implements UiValidator {
  final int minLength;
  LoginUiValidator({required this.minLength});

  @override
  void isValid(String value) {
    if (value.length < minLength) {
      throw LoginValidateException('Length must be at least $minLength characters');
    }
    final isEmail = EmailValidator.validate(value);
    final isSnils = value.length == 14 &&
        value[3] == '-' &&
        value[7] == '-' &&
        value[11] == ' ';
    if (!(isSnils || isEmail)) {
      throw LoginValidateException('Incorrect login');
    }
  }
}

class PasswordUiValidator implements UiValidator {
  final int minLength;
  PasswordUiValidator({required this.minLength});

  @override
  void isValid(String value) {
    if (value.length < minLength) {
      throw PasswordValidateException('Length must be at least $minLength characters');
    }
  }
}
