import 'package:fake_store/features/login/domain/entity/login_result.dart';

abstract class LoginRepository {
  Future<LoginResult> login(String login, String password);
  Future<LoginResult> signUp(String login, String password);
  Future<void> logOut();
}