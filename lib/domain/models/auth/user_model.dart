class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final int syncCode;

  const UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.syncCode,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      syncCode: json['syncCode'],
    );
  }

  String get fullName => '$firstName $lastName';
}
