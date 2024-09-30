class ResponseProps<T> {
  bool success;
  Result<T>? result;

  ResponseProps({required this.success, this.result});
}

class Result<T> {
  String? message;
  T? data;

  Result({this.message, this.data});
}

class ResponseScan {
  num errorCode;
  String errorMessage;
  dynamic data;

  ResponseScan(this.errorCode, this.errorMessage, this.data);
}
