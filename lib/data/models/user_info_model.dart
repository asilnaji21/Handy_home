class UserInfoModel {
  final String firstName;
  final String lastName;
  final String email;
  final String image;

  UserInfoModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> map) {
    return UserInfoModel(
      firstName: map["first_name"],
      lastName: map["last_name"],
      email: map["email"],
      image: map["image"],
    );
  }
}
