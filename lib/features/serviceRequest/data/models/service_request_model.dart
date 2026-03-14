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
      id: map['id'] as String? ?? '',
      customerId: map['customer_id'] as String? ?? '',
      workerId: map['worker_id'] as String? ?? '',
      // Handle the null service_id found in your logs
      serviceId: map['service_id'] as String? ?? '',
      title: map['title'] as String? ?? 'No Title',
      description: map['description'] as String? ?? '',
      status: map['status'] as String? ?? 'pending',
      // Handle the null location found in your logs
      location: map['location'] as String? ?? 'No Location Provided',
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'])
          : DateTime.now(),
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
