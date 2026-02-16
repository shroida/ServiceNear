import '../../domain/entities/rating_entity.dart';

class RatingModel extends RatingEntity {
  RatingModel({
    required super.ratingrId,
    required super.workerId,
    required super.customerId,
    required super.rating,
    required super.review,
    required super.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": ratingrId,
      "worker_id": workerId,
      "customer_id": customerId,
      "rating": rating,
      "review": review,
      "created_at": createdAt,
    };
  }
}
