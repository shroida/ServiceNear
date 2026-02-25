import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/widgets/app_styles.dart';
import 'package:servicenear/common/widgets/app_text_form_field.dart';

class ChatListView extends StatelessWidget {
  const ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),

              Text("Messages", style: AppStyles.font24BlueBold),

              SizedBox(height: 20.h),

              AppTextFormField(
                hintText: 'Search for services or workers',
                validator: (_) => null,
                hintStyle: AppStyles.font14GrayRegular,
                prefixIcon: const Icon(Icons.search, color: AppColors.textHint),
                backgroundColor: AppColors.scaffoldBackground,
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

              SizedBox(height: 20.h),

              Expanded(
                child: ListView.separated(
                  itemCount: 10,
                  separatorBuilder: (_, _) => Divider(color: AppColors.divider),
                  itemBuilder: (context, index) {
                    return const ChatItem();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
