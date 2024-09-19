class ResponseProps<T> {
  bool? success;
  Result<T>? result;

  ResponseProps({this.success, this.result});
}

class Result<T> {
  String? message;
  T? data;

  Result({this.message, this.data});
}
