import '../../domain/entities/service_request.dart';

class ServiceRequestModel extends ServiceRequest {
  ServiceRequestModel({
    required super.id,
    required super.customerId,
    required super.workerId,
    required super.title,
    required super.description,
    required super.status,
    super.location,
    super.price,
    required super.createdAt,
  });

  factory ServiceRequestModel.fromMap(Map<String, dynamic> map) {
    return ServiceRequestModel(
      id: map['id'],
      customerId: map['customer_id'],
      workerId: map['worker_id'],
      title: map['title'],
      description: map['description'] ?? '',
      status: map['status'],
      location: map['location'],
      price: map['price']?.toDouble(),
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customer_id': customerId,
      'worker_id': workerId,
      'title': title,
      'description': description,
      'status': status,
      'location': location,
      'price': price,
    };
  }
}
