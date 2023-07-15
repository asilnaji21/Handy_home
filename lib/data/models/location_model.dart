class LocationModel {
  final int id;
  final String detail;
  final String country;
  final String city;
  final String building;
  final String apartmentNumber;
  final String phoneNumber;
  final int user;
  final String addressName;

  LocationModel({
    required this.id,
    required this.detail,
    required this.country,
    required this.city,
    required this.building,
    required this.apartmentNumber,
    required this.phoneNumber,
    required this.user,
    required this.addressName,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
        id: json['id'],
        detail: json['detail'],
        country: json['country'],
        city: json['city'],
        building: json['building'],
        apartmentNumber: json['apartment_number'],
        phoneNumber: json['phone_number'],
        user: json['user'],
        addressName: json['address_name']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['detail'] = detail;
    data['country'] = country;
    data['city'] = city;
    data['building'] = building;
    data['apartment_number'] = apartmentNumber;
    data['phone_number'] = phoneNumber;
    data['user'] = user;
    data['address_name'] = addressName;
    return data;
  }
}
