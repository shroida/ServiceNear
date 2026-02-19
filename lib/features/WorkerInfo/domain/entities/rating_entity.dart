class RatingEntity {
  final String workerId;
  final String customerId;
  final double rating;
  final String review;
  final DateTime createdAt;

  RatingEntity({
    required this.workerId,
    required this.customerId,
    required this.rating,
    required this.review,
    required this.createdAt,
  });
}
