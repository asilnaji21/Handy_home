class NotificationModel {
  final int id;
  final String text;
  final String orderStatus;

  NotificationModel({
    required this.id,
    required this.text,
    required this.orderStatus,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> map) {
    return NotificationModel(
      id: map["id"],
      text: map["text"],
      orderStatus: map["order_status"],
    );
  }
}
