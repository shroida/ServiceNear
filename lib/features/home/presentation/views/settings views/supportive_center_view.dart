import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/widgets/app_styles.dart';

class SupportCenterView extends StatelessWidget {
  const SupportCenterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        title: Text("Support Center", style: AppStyles.font18DarkBlueBold),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            _buildContactMethod(
              Icons.chat_bubble_outline,
              "Live Chat",
              "Talk to our team right now",
            ),
            _buildContactMethod(
              Icons.mail_outline,
              "Email Support",
              "Get a response within 24 hours",
            ),
            _buildContactMethod(
              Icons.help_center_outlined,
              "FAQs",
              "Common questions answered",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactMethod(IconData icon, String title, String sub) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.only(bottom: 15.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withValues(alpha: 0.1),
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(title, style: AppStyles.font14DarkBlueMedium),
        subtitle: Text(sub, style: AppStyles.font12GrayMedium),
        onTap: () {},
      ),
    );
  }
}
