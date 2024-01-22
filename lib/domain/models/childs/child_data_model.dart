class ChildDataModel {
  final String name;
  final String uuid;
  final int totalTime;
  final int appCount;
  final String deviceName;

  const ChildDataModel({
    required this.name,
    required this.uuid,
    required this.totalTime,
    required this.appCount,
    required this.deviceName,
  });

  factory ChildDataModel.fromJson(Map<String, dynamic> json) {
    return ChildDataModel(
      name: json['name'],
      uuid: json['uuid'],
      totalTime: json['totalTime'],
      appCount: json['appCount'],
      deviceName: json['deviceName'] ?? 'iPhone 12 Pro Max',
    );
  }
}
