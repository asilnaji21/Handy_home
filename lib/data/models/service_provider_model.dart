class ServiceProviderModel {
  final int id;
  final String name;
  final String phoneNumber;
  final String location;
  final int yearExperience;
  final String summaryExperience;
  final String additional;
  final int user;
  final int category;

  ServiceProviderModel(
      {required this.id,
      required this.name,
      required this.phoneNumber,
      required this.location,
      required this.yearExperience,
      required this.summaryExperience,
      required this.additional,
      required this.user,
      required this.category});

  factory ServiceProviderModel.fromJson(Map<String, dynamic> json) {
    return ServiceProviderModel(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phone_number'],
      location: json['location'],
      yearExperience: json['year_experience'],
      summaryExperience: json['summary_experience'],
      additional: json['additional'],
      user: json['user'],
      category: json['category'],
    );
  }
}
