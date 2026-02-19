import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomerReviewsWidget extends StatelessWidget {
  final String workerId;

  const CustomerReviewsWidget({super.key, required this.workerId});

  Future<List<Map<String, dynamic>>> fetchReviews() async {
    final client = Supabase.instance.client;

    final response = await client
        .from('ratings')
        .select()
        .eq('worker_id', workerId)
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchReviews(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Error loading reviews',
              style: TextStyle(color: Colors.red),
            ),
          );
        }

        final reviews = snapshot.data ?? [];

        if (reviews.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Text('No reviews yet.'),
          );
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: reviews.length,
          separatorBuilder: (_, __) => const Divider(height: 24),
          itemBuilder: (context, index) {
            final review = reviews[index];

            final double rating = (review['rating'] as num?)?.toDouble() ?? 0.0;
            final String reviewText = review['review']?.toString() ?? '';
            final String customerId = review['customer_id']?.toString() ?? '';
            final String createdAt = review['created_at']?.toString() ?? '';

            return ListTile(
              leading: CircleAvatar(
                child: Text(
                  customerId.isNotEmpty
                      ? customerId.substring(0, 2).toUpperCase()
                      : 'U',
                ),
              ),
              title: Row(
                children: [
                  Text(rating.toStringAsFixed(1)),
                  const SizedBox(width: 4),
                  const Icon(Icons.star, size: 16, color: Colors.amber),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (reviewText.isNotEmpty) Text(reviewText),
                  const SizedBox(height: 4),
                  Text(
                    createdAt,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
