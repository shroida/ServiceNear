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

    if (response is List) {
      return List<Map<String, dynamic>>.from(response);
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchReviews(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Error loading reviews: ${snapshot.error}'),
          );
        }

        final reviews = snapshot.data ?? [];

        if (reviews.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('No reviews yet.'),
          );
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: reviews.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            final review = reviews[index];
            final rating = review['rating'] ?? 0.0;
            final reviewText = review['review'] ?? '';
            final customerId = review['customer_id'] ?? '';
            final createdAt = review['created_at'] ?? '';

            return ListTile(
              leading: CircleAvatar(
                child: Text(
                  customerId.toString().substring(0, 2).toUpperCase(),
                ),
              ),
              title: Row(
                children: [
                  Text('Rating: $rating'),
                  const SizedBox(width: 8),
                  Icon(Icons.star, color: Colors.amber, size: 16),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(reviewText),
                  const SizedBox(height: 4),
                  Text(
                    createdAt.toString(),
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
