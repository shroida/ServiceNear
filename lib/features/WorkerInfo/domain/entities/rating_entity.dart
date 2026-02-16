class RatingEntity {
  final String workerId;
  final String customerId;
  final double rating;
  final String review;

  RatingEntity({
    required this.workerId,
    required this.customerId,
    required this.rating,
    required this.review,
  });
}
