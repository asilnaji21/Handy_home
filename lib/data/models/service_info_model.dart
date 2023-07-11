class ServiceInfoModel {
  final String serviceName;
  final String date;
  final String time;
  final String count;
  final String totalPrice;
  final bool isCustom;
  final String description;
  ServiceInfoModel({
    required this.serviceName,
    required this.date,
    required this.time,
    required this.count,
    required this.totalPrice,
    required this.isCustom,
    required this.description,
  });

  @override
  String toString() {
    return 'ServiceInfoModel(serviceName: $serviceName, date: $date, time: $time, count: $count, totalPrice: $totalPrice)';
  }
}
