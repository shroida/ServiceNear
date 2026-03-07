class ServiceRequest {
  final String? id;
  final String customerId;
  final String workerId;
  final String title;
  final String description;
  final String status;
  final String? location;
  final double? price;
  final DateTime createdAt;

  ServiceRequest({
    this.id,
    required this.customerId,
    required this.workerId,
    required this.title,
    required this.description,
    required this.status,
    this.location,
    this.price,
    required this.createdAt,
  });
}
