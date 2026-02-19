import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicenear/features/WorkerInfo/presentation/cubit/worker_info_cubit.dart';
import 'package:servicenear/features/WorkerInfo/presentation/cubit/worker_info_state.dart';

class CustomerReviewsWidget extends StatefulWidget {
  final String workerId;

  const CustomerReviewsWidget({super.key, required this.workerId});

  @override
  State<CustomerReviewsWidget> createState() => _CustomerReviewsWidgetState();
}

class _CustomerReviewsWidgetState extends State<CustomerReviewsWidget> {
  @override
  void initState() {
    super.initState();
    context.read<WorkerInfoCubit>().fetchReviews(widget.workerId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkerInfoCubit, RatingState>(
      builder: (context, state) {
        if (state is RatingLoading) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is RatingError) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (state is RatingLoaded) {
          final reviews = state.reviews;

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

              return ListTile(
                leading: CircleAvatar(
                  child: Text(review.customerId.substring(0, 2).toUpperCase()),
                ),
                title: Row(
                  children: [
                    Text(review.rating.toStringAsFixed(1)),
                    const SizedBox(width: 4),
                    const Icon(Icons.star, size: 16, color: Colors.amber),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (review.review.isNotEmpty) Text(review.review),
                    const SizedBox(height: 4),
                    Text(
                      review.createdAt.toString(),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
