abstract class DataState<T> {
  final T? data;
  final String? error;

  bool isSuccess();

  const DataState({this.data, this.error});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);

  @override
  bool isSuccess() => true;
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(String error) : super(error: error);

  @override
  bool isSuccess() => false;
}
