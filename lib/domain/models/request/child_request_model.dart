class ChildRequestModel {
  final String name;
  final String uuid;
  final String deviceName;

  const ChildRequestModel({
    required this.name,
    required this.uuid,
    required this.deviceName,
  });

  factory ChildRequestModel.fromJson(Map<String, dynamic> json) {
    return ChildRequestModel(
      name: json['name'],
      uuid: json['uuid'],
      deviceName: json['deviceName'] ?? 'iPhone 12 Pro Max',
    );
  }
}
