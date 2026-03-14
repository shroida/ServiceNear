class ServiceRequest {
  final String? id;
  final String customerId;
  final String workerId;
  final String serviceId;
  final String title;
  final String description;
  final String status;
  final String? location;
  final DateTime createdAt;

  ServiceRequest({
    this.id,
    required this.customerId,
    required this.workerId,
    required this.title,
    required this.description,
    required this.status,
    required this.serviceId,
    this.location,
    required this.createdAt,
  });
}
