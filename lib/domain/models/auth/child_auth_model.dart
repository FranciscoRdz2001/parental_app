class ChildAuthModel {
  final String token;
  final int status;
  final String message;

  const ChildAuthModel({
    required this.token,
    required this.status,
    required this.message,
  });

  factory ChildAuthModel.fromJson(Map<String, dynamic> json) {
    return ChildAuthModel(
      token: json['token'],
      status: json['childStatus'],
      message: json['message'],
    );
  }
}
