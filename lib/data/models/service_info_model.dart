// ignore_for_file: public_member_api_docs, sort_constructors_first
class ServiceInfoModel {
  final String serviceName;
  final String date;
  final String time;
  final String count;
  final String totalPrice;

  ServiceInfoModel({
    required this.serviceName,
    required this.date,
    required this.time,
    required this.count,
    required this.totalPrice,
  });

  @override
  String toString() {
    return 'ServiceInfoModel(serviceName: $serviceName, date: $date, time: $time, count: $count, totalPrice: $totalPrice)';
  }
}
