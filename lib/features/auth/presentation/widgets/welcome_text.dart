import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/widgets/app_styles.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Welcome!',
          style: AppStyles.font32BlueBold,
        ),
        SizedBox(height: 10.h),
        Text(
          'Please enter your details',
          style: AppStyles.font16WhiteSemiBold
              .copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
