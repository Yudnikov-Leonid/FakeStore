import 'package:fake_store/core/data_state.dart';
import 'package:fake_store/core/presentation/ui_validator.dart';
import 'package:fake_store/core/presentation/validation_exceptions.dart';
import 'package:fake_store/core/usecase.dart';
import 'package:fake_store/features/login/domain/entity/login_result.dart';
import 'package:fake_store/features/login/domain/repository/login_repository.dart';

class LoginUseCase
    implements UseCase<LoginResult, (String, String)?> {
  final LoginRepository _repository;
  final UiValidator _loginValidator;
  final UiValidator _passwordValidator;
  LoginUseCase(this._repository, this._loginValidator, this._passwordValidator);

  @override
  Future<LoginResult> call({(String, String)? params}) async {
    try {
      _loginValidator.isValid(params!.$1);
      _passwordValidator.isValid(params.$2);
      return _repository.signIn(params!.$1, params.$2);
    } on LoginValidateException catch (e) {
      return LoginLoginFail(e.message);
    } on PasswordValidateException catch (e) {
      return LoginPasswordFail(e.message);
    }
  }
}
