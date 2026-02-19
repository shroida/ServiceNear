import '../../domain/entities/rating_entity.dart';

class RatingModel extends RatingEntity {
  RatingModel({
    required super.workerId,
    required super.customerId,
    required super.rating,
    required super.review,
    required super.createdAt,
  });
  factory RatingModel.fromMap(Map<String, dynamic> map) {
    return RatingModel(
      workerId: map['worker_id'],
      customerId: map['customer_id'],
      rating: (map['rating'] as num).toDouble(),
      review: map['review'] ?? '',
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "worker_id": workerId,
      "customer_id": customerId,
      "rating": rating,
      "review": review,
      "created_at": createdAt,
    };
  }
}
