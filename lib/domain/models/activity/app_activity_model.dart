class AppActivityModel {
  String? name;
  String package;
  int time;

  AppActivityModel({
    this.name,
    required this.package,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'package': package,
      'time': time,
    };
  }
}
