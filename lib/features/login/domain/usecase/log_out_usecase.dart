import 'package:fake_store/core/usecase.dart';
import 'package:fake_store/features/login/domain/repository/login_repository.dart';

class LogOutUseCase implements UseCase<void, void> {
  final LoginRepository _repository;
  LogOutUseCase(this._repository);

  @override
  Future<void> call({void params}) async {
    await _repository.logOut();
  }
}