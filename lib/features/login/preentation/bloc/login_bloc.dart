import 'package:fake_store/features/login/domain/entity/login_result.dart';
import 'package:fake_store/features/login/domain/usecase/log_out_usecase.dart';
import 'package:fake_store/features/login/domain/usecase/login_usecase.dart';
import 'package:fake_store/features/login/domain/usecase/sign_up_usecase.dart';
import 'package:fake_store/features/login/preentation/bloc/login_event.dart';
import 'package:fake_store/features/login/preentation/bloc/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  final SignUpUseCase signUpUseCase;
  final LogOutUseCase logOutUseCase;

  LoginBloc(
      {required this.loginUseCase,
      required this.signUpUseCase,
      required this.logOutUseCase})
      : super(FirebaseAuth.instance.currentUser == null
            ? LoginInitial()
            : LoginSuccess()) {
    on<LoginLoginEvent>(_onLoginLoginEvent);
    on<LoginSignUpEvent>(_onLoginSignUpEvent);
    on<LoginHideErrorsEvent>(_onHideErrorsEvent);
    on<LoginLogOutEvent>(_onLogOutEvent);
  }

  void _onLogOutEvent(LoginLogOutEvent event, Emitter<LoginState> emit) async {
    await logOutUseCase();
    emit(LoginInitial());
  }

  void _onHideErrorsEvent(
      LoginHideErrorsEvent event, Emitter<LoginState> emit) {
    emit(LoginInitial());
  }

  void _onLoginSignUpEvent(
      LoginSignUpEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    final result = await signUpUseCase(params: (event.login, event.password));
    if (result is LoginSuccessResult) {
      emit(LoginSuccess());
    } else if (result is LoginLoginFail) {
      emit(LoginEmailError(result.message));
    } else if (result is LoginPasswordFail) {
      emit(LoginPasswordError(result.message));
    } else {
      emit(LoginFailed(result.message));
    }
  }

  void _onLoginLoginEvent(
      LoginLoginEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    final result = await loginUseCase(params: (event.login, event.password));
    if (result is LoginSuccessResult) {
      emit(LoginSuccess());
    } else if (result is LoginLoginFail) {
      emit(LoginEmailError(result.message));
    } else if (result is LoginPasswordFail) {
      emit(LoginPasswordError(result.message));
    } else {
      emit(LoginFailed(result.message));
    }
  }
}
