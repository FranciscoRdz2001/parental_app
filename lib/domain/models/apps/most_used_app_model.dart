import 'dart:developer';

class MostUsedAppModel {
  final int totalTime;
  final String name;
  final String package;
  final int devices;
  final List<MostUsedAppUserModel> users;
  final String? icon;

  const MostUsedAppModel({
    required this.totalTime,
    required this.name,
    required this.package,
    required this.devices,
    required this.users,
    this.icon,
  });

  factory MostUsedAppModel.fromJson(Map<String, dynamic> json) {
    log('MostUsedAppModel: $json');
    return MostUsedAppModel(
      totalTime: json['totalTime'],
      name: json['name'],
      package: json['package'],
      devices: json['devices'],
      icon: json['icon'],
      users: List<MostUsedAppUserModel>.from(
        json['users'].map(
          (x) => MostUsedAppUserModel.fromJson(x),
        ),
      ),
    );
  }
}

class MostUsedAppUserModel {
  final String name;
  final int totalTime;
  final String uuid;

  const MostUsedAppUserModel({
    required this.name,
    required this.totalTime,
    required this.uuid,
  });

  factory MostUsedAppUserModel.fromJson(Map<String, dynamic> json) {
    return MostUsedAppUserModel(
      name: json['name'],
      totalTime: json['totalTime'],
      uuid: json['uuid'],
    );
  }
}
