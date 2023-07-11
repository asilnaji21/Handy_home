class CustomServiceModel {
  final String status;
  final int id;
  final String name;
  final String description;
  final String date;
  final String time;
  final int requestedBy;
  final int category;
  final int location;
  final String orderStatus;

  CustomServiceModel(
      {required this.status,
      required this.id,
      required this.name,
      required this.description,
      required this.date,
      required this.time,
      required this.requestedBy,
      required this.category,
      required this.location,
      required this.orderStatus});

  factory CustomServiceModel.fromJson(Map<String, dynamic> map) {
    return CustomServiceModel(
      status: map["detail"]["status"],
      id: map["detail"]["services"]["id"],
      name: map["detail"]["services"]["name"],
      description: map["detail"]["services"]["descriptions"],
      date: map["detail"]["services"]["request_date"],
      time: map["detail"]["services"]["request_time"],
      requestedBy: map["detail"]["services"]["request_by"],
      category: map["detail"]["services"]["category"],
      location: map["detail"]["services"]["location"],
      orderStatus: map["detail"]["order_status"],
    );
  }
}

// {
//     "detail": {
//         "status": "تم إنشاء طلب خدمة مخصصة بنجاح",
//         "services": {
//             "id": 5,
//             "name": "mohammed naji",
//             "descriptions": "create home servcie",
//             "request_date": "2023-07-09",
//             "request_time": "03:30:00",
//             "request_by": 23,
//             "category": 1,
//             "location": 5
//         },
//         "order_status": "قيد المراجعة"
//     }
// }