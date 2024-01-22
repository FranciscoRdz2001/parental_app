class ServerResponse<T> {
  ServerResponse({
    required this.isSuccess,
    this.message,
    this.result,
    required this.statusCode,
    this.defaultCode,
  });
  bool isSuccess;
  String? message;
  T? result;
  int statusCode;
  String? defaultCode;

  dynamic get response {
    return result;
  }

  String get code {
    return defaultCode ?? '';
  }
}
