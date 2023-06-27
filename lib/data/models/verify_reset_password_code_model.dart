class ResetPasswordCodeModel {
  final String detail;
  final String token;
  ResetPasswordCodeModel({
    required this.detail,
    required this.token,
  });

  factory ResetPasswordCodeModel.fromJson(Map<String, dynamic> map) {
    return ResetPasswordCodeModel(detail: map["detail"], token: map["token"]);
  }
}
