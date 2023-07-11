class OrderedServiceModel {
  final String? name;
  final int id;
  final String orderStatus;
  final int quantity;
  final int totalPrice;
  final String dateOrder;
  final String timeOrder;
  final String createAt;
  final String updateAt;
  final int createBy;
  final int service;

  OrderedServiceModel(
      {required this.id,
      this.name,
      required this.orderStatus,
      required this.quantity,
      required this.totalPrice,
      required this.dateOrder,
      required this.timeOrder,
      required this.createAt,
      required this.updateAt,
      required this.createBy,
      required this.service});

  factory OrderedServiceModel.fromJson(Map<String, dynamic> json) {
    return OrderedServiceModel(
      id: json['id'],
      orderStatus: json['order_status'],
      quantity: json['quantity'],
      totalPrice: json['total_price'] ?? 0,
      dateOrder: json['date_order'],
      timeOrder: json['time_order'],
      createAt: json['create_at'],
      updateAt: json['update_at'],
      createBy: json['create_by'],
      service: json['service'],
      name: json['service_name']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['order_status'] = orderStatus;
    data['quantity'] = quantity;
    data['total_price'] = totalPrice;
    data['date_order'] = dateOrder;
    data['time_order'] = timeOrder;
    data['create_at'] = createAt;
    data['update_at'] = updateAt;
    data['create_by'] = createBy;
    data['service'] = service;
    return data;
  }
}
