class RefreshModel {
  RefreshModel({
    required this.refresh,
    required this.access,
    required this.accessTokenExpiration,
  });

  factory RefreshModel.fromJson(Map<String, dynamic> json) => RefreshModel(
        refresh: json['refresh'] as String? ?? '',
        access: json['access'] as String? ?? '',
        accessTokenExpiration: json['access_token_expiration'] as String? ?? '',
      );

  final String refresh;
  final String access;
  final String accessTokenExpiration;

  Map<String, dynamic> toJson() => {
        'refresh': refresh,
        'access': access,
        'access_token_expiration': accessTokenExpiration,
      };
}
