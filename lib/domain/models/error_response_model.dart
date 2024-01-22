class ErrorResponse {
  ErrorResponse({
    required this.defaultCode,
    required this.detail,
    required this.statusCode,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        defaultCode: json['default_code'] as String? ?? '',
        detail: json['detail'] as String? ?? '',
        statusCode: json['status_code'] as int? ?? 0,
      );

  final String defaultCode;
  final String detail;
  final int statusCode;

  Map<String, dynamic> toJson() => {
        'default_code': defaultCode,
        'detail': detail,
        'status_code': statusCode,
      };
}
