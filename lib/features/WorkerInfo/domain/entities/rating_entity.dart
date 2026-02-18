class RatingEntity {
  final String ratingrId;
  final String workerId;
  final String customerId;
  final double rating;
  final String review;
  final DateTime createdAt;

  RatingEntity({
    required this.ratingrId,
    required this.workerId,
    required this.customerId,
    required this.rating,
    required this.review,
    required this.createdAt,
  });
}
