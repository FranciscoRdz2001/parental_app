class UserActivityModel {
  final String name;
  final String? package;
  final int time;
  final String? deviceName;

  const UserActivityModel({
    required this.name,
    required this.package,
    required this.time,
    this.deviceName,
  });

  factory UserActivityModel.fromJson(Map<String, dynamic> json) {
    return UserActivityModel(
      name: json['name'],
      package: json['package'],
      time: json['time'],
      deviceName: json['deviceName'],
    );
  }
}
