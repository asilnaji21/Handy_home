// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String refreshToken;
  final String accessToken;
  UserModel({
    required this.refreshToken,
    required this.accessToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      refreshToken: map["refresh"],
      accessToken: map["access"],
    );
  }

  Map<String, dynamic> toJson() =>
      {"refresh": refreshToken, "access": accessToken};

  @override
  String toString() => 'UserModel(refreshToken: $refreshToken, accessToken: $accessToken)';
}
