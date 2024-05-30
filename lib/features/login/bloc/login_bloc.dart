import 'package:fake_store/features/login/bloc/login_event.dart';
import 'package:fake_store/features/login/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginLoginEvent>(_onLoginLoginEvent);
  }

  void _onLoginLoginEvent(LoginLoginEvent event, Emitter<LoginState> emit) {
    
  }
}