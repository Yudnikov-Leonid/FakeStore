import 'package:fake_store/core/presentation/ui_validator.dart';
import 'package:fake_store/features/login/data/repository/login_repository_impl.dart';
import 'package:fake_store/features/login/domain/repository/login_repository.dart';
import 'package:fake_store/features/login/domain/usecase/login_usecase.dart';
import 'package:fake_store/features/login/domain/usecase/sign_up_usecase.dart';
import 'package:fake_store/features/login/preentation/bloc/login_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void initializeDependencies() {
  final _loginRepository = LoginRepositoryImpl();
  final _loginValidator = LoginUiValidator(minLength: 3);
  final _passwordValidator = PasswordUiValidator(minLength: 6);
  
  sl.registerFactory<LoginBloc>(() => LoginBloc(
      loginUseCase:
          LoginUseCase(_loginRepository, _loginValidator, _passwordValidator),
      signUpUseCase: SignUpUseCase(
          _loginRepository, _loginValidator, _passwordValidator)));
}
