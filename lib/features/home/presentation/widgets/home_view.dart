import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/widgets/app_styles.dart';
import 'package:servicenear/common/widgets/app_text_form_field.dart';
import 'package:servicenear/features/auth/domain/entities/app_user.dart';

class HomeView extends StatelessWidget {
  final AppUser user;
  const HomeView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextFormField(
              hintText: 'Search for services or workers',
              validator: (_) => null,
              hintStyle: AppStyles.font14GrayRegular,
              prefixIcon: const Icon(Icons.search, color: AppColors.textHint),
              backgroundColor: AppColors.divider,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 20.h,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide.none,
              ),
            ),
            SizedBox(height: 10),
            Text('Categories', style: AppStyles.font18DarkMedium),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
