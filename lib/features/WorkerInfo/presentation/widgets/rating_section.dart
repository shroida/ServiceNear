import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/widgets/app_styles.dart';
import '../cubit/worker_info_cubit.dart';
import '../cubit/worker_info_state.dart';

class RatingSection extends StatelessWidget {
  final String workerId;
  const RatingSection({super.key, required this.workerId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkerInfoCubit, RatingState>(
      builder: (context, state) {
        if (state is! RatingLoaded) return const SizedBox.shrink();

        double avg = state.reviews.isEmpty
            ? 0
            : state.reviews.map((r) => r.rating).reduce((a, b) => a + b) /
                  state.reviews.length;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Reviews & Ratings",
                    style: AppStyles.font18DarkBlueBold,
                  ),
                  Text("See All", style: AppStyles.font13BlueSemiBold),
                ],
              ),
              SizedBox(height: 15.h),
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        avg.toStringAsFixed(1),
                        style: AppStyles.font32BlueBold,
                      ),
                      _buildStars(avg),
                      SizedBox(height: 4.h),
                      Text(
                        "${state.reviews.length} reviews",
                        style: AppStyles.font12GrayMedium,
                      ),
                    ],
                  ),
                  SizedBox(width: 30.w),
                  // Simple mini-bars (Visual only for "awesomeness")
                  Expanded(
                    child: Column(
                      children: List.generate(
                        3,
                        (index) => _buildMiniBar(1.0 - (index * 0.2)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMiniBar(double widthFactor) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: LinearProgressIndicator(
        value: widthFactor,
        backgroundColor: Colors.grey[200],
        color: AppColors.primary,
        minHeight: 6.h,
        borderRadius: BorderRadius.circular(10.r),
      ),
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
