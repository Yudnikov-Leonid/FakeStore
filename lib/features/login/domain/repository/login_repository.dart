import 'package:fake_store/core/data_state.dart';
import 'package:fake_store/features/login/domain/entity/login_result.dart';

abstract class LoginRepository {
  Future<LoginResult> login(String login, String password);
  Future<LoginResult> signIn(String login, String password);
  Future<void> logOut();
}