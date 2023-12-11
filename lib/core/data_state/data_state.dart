abstract class DataState<T> {
  final T? data;
  final (Exception exception, StackTrace stackTrace)? error;

  const DataState({this.data, this.error});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);

  @override
  String toString() => data.toString();
}

class DataFailed<T> extends DataState<T> {
  DataFailed(exception, stackTrace) : super(error: (exception, stackTrace));
}
