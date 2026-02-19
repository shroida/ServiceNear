import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:servicenear/features/WorkerInfo/domain/entities/rating_entity.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.review});

  final RatingEntity review;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header Row
              Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.blue.shade100,
                    child: Text(
                      review.customerId.substring(0, 2).toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  /// Rating Stars
                  Row(
                    children: List.generate(
                      5,
                      (starIndex) => Icon(
                        starIndex < review.rating.round()
                            ? Icons.star
                            : Icons.star_border,
                        size: 18,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// Review Text
              if (review.review.isNotEmpty)
                Expanded(
                  child: Text(
                    review.review,
                    style: const TextStyle(fontSize: 14, height: 1.4),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

              const SizedBox(height: 12),

              /// Date
              Text(
                DateFormat.yMMMd().format(review.createdAt),
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
