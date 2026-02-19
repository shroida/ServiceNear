import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenear/features/WorkerInfo/presentation/cubit/worker_info_cubit.dart';
import 'package:servicenear/features/WorkerInfo/presentation/cubit/worker_info_state.dart';
import 'package:servicenear/features/WorkerInfo/presentation/widgets/review_card.dart';

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

          return SizedBox(
            height: 250.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];

                return ReviewCard(review: review);
              },
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
