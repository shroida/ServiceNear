import '../../domain/entities/service_request.dart';

class ServiceRequestModel extends ServiceRequest {
  ServiceRequestModel({
    required super.id,
    required super.customerId,
    required super.workerId,
    required super.title,
    required super.description,
    required super.status,
    required super.serviceId,

    super.location,
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
      serviceId: map['service_id'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'customer_id': customerId,
      'worker_id': workerId,
      'title': title,
      'description': description,
      'status': status,
      'location': location,
      'service_id': serviceId,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
