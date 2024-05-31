import 'package:fake_store/features/login/domain/entity/login_result.dart';
import 'package:fake_store/features/login/domain/repository/login_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginRepositoryImpl implements LoginRepository {
  @override
  Future<LoginResult> login(String login, String password) async {
    try {
      final auth = FirebaseAuth.instance;
      await auth.signInWithEmailAndPassword(
          email: login, password: password);
      return LoginSuccessResult();
    } catch (e) {
      return LoginFail(e.toString());
    }
  }

  @override
  Future<LoginResult> signIn(String login, String password) async {
    try {
      final auth = FirebaseAuth.instance;
      await auth.createUserWithEmailAndPassword(
          email: login, password: password);
      return LoginSuccessResult();
    } catch (e) {
      return LoginFail(e.toString());
    }
  }
  
  @override
  Future<void> logOut() async {
    final auth = FirebaseAuth.instance;
    auth.signOut();
  }
}
