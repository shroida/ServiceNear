import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicenear/common/core/app_colors.dart';
import '../cubit/worker_info_cubit.dart';
import '../cubit/worker_info_state.dart';

class RatingSection extends StatelessWidget {
  final String workerId;

  const RatingSection({super.key, required this.workerId});

  @override
  Widget build(BuildContext context) {
    // Trigger fetch when first built
    context.read<WorkerInfoCubit>().fetchReviews(workerId);

    return BlocBuilder<WorkerInfoCubit, RatingState>(
      builder: (context, state) {
        double averageRating = 0;
        int reviewsCount = 0;

        if (state is RatingLoaded && state.reviews.isNotEmpty) {
          reviewsCount = state.reviews.length;
          averageRating =
              state.reviews.map((r) => r.rating).reduce((a, b) => a + b) /
              reviewsCount;
        }

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStars(averageRating),
              Text(
                state is RatingLoaded
                    ? "${averageRating.toStringAsFixed(1)} ($reviewsCount Reviews)"
                    : "Loading...",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStars(double rating) {
    List<Widget> stars = [];
    for (int i = 1; i <= 5; i++) {
      if (rating >= i) {
        stars.add(const Icon(Icons.star, color: AppColors.primary, size: 20));
      } else if (rating > i - 1 && rating < i) {
        stars.add(
          const Icon(Icons.star_half, color: AppColors.primary, size: 20),
        );
      } else {
        stars.add(
          const Icon(Icons.star_border, color: AppColors.primary, size: 20),
        );
      }
    }
    return Row(children: stars);
  }
}
