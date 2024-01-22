import 'package:parental_app/domain/models/request/child_request_model.dart';

class ChildInfoStatusModel extends ChildRequestModel {
  final int status;

  ChildInfoStatusModel({
    required this.status,
    required super.deviceName,
    required super.name,
    required super.uuid,
  });

  factory ChildInfoStatusModel.fromJson(Map<String, dynamic> json) {
    return ChildInfoStatusModel(
      status: json['status'],
      name: json['name'],
      uuid: json['uuid'],
      deviceName: json['deviceName'],
    );
  }
}
