import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/widgets/app_styles.dart';

class CustomerRatingWidget extends StatefulWidget {
  final Function(double rating, String review)? onSubmit;

  const CustomerRatingWidget({super.key, this.onSubmit});

  @override
  State<CustomerRatingWidget> createState() => _CustomerRatingWidgetState();
}

class _CustomerRatingWidgetState extends State<CustomerRatingWidget> {
  double selectedRating = 0;
  final TextEditingController reviewController = TextEditingController();

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!isExpanded)
          GestureDetector(
            onTap: () {
              setState(() => isExpanded = true);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              padding: EdgeInsets.symmetric(vertical: 14.h),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text("Add Review", style: AppStyles.font16WhiteSemiBold),
              ),
            ),
          ),

        AnimatedCrossFade(
          firstChild: const SizedBox(),
          secondChild: _buildRatingCard(),
          crossFadeState: isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
      ],
    );
  }

  Widget _buildRatingCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Rate This Worker", style: AppStyles.font18DarkGreyMedium),
          SizedBox(height: 15.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedRating = index + 1.0;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Icon(
                    Icons.star,
                    size: 32.sp,
                    color: index < selectedRating
                        ? AppColors.warning
                        : AppColors.border,
                  ),
                ),
              );
            }),
          ),

          SizedBox(height: 20.h),

          TextField(
            controller: reviewController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: "Write your review...",
              hintStyle: AppStyles.font13GrayRegular,
              filled: true,
              fillColor: AppColors.background,
              contentPadding: EdgeInsets.all(14.w),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          SizedBox(height: 20.h),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
              onPressed: () {
                if (selectedRating == 0) return;

                widget.onSubmit?.call(selectedRating, reviewController.text);

                reviewController.clear();

                setState(() {
                  selectedRating = 0;
                  isExpanded = false;
                });
              },
              child: Text(
                "Submit Review",
                style: AppStyles.font16WhiteSemiBold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
