abstract class DataState<T> {
  final T? data;
  final (Exception exception, StackTrace stackTrace)? error;

  const DataState({this.data, this.error});
}

class Success<T> extends DataState<T> {
  const Success(T data) : super(data: data);

  @override
  String toString() => data.toString();
}

class Failed<T> extends DataState<T> {
  const Failed(Exception exception, StackTrace stackTrace) : super(error: (exception, stackTrace));
}

class Empty<T> extends DataState<T> {
  const Empty() : super();
}
