class ServiceRequest {
  final String id;
  final int customerId;
  final int workerId;
  final String title;
  final String description;
  final String status;
  final String? location;
  final double? price;
  final DateTime createdAt;

  ServiceRequest({
    required this.id,
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
