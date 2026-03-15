import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/widgets/app_styles.dart';

class PrivacySecurityView extends StatelessWidget {
  const PrivacySecurityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        title: Text("Privacy & Security", style: AppStyles.font18DarkBlueBold),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.w),
        children: [
          _buildOption(
            Icons.lock_outline,
            "Change Password",
            "Update your secret key",
          ),
          _buildOption(
            Icons.fingerprint,
            "Biometric ID",
            "Face ID or Fingerprint",
          ),
          _buildOption(
            Icons.visibility_off_outlined,
            "Hide Profile",
            "Temporarily hide your business",
          ),
          _buildOption(
            Icons.delete_forever,
            "Delete Account",
            "Permanently remove your data",
            isWarning: true,
          ),
        ],
      ),
    );
  }

  Widget _buildOption(
    IconData icon,
    String title,
    String sub, {
    bool isWarning = false,
  }) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.only(bottom: 12.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      child: ListTile(
        leading: Icon(icon, color: isWarning ? Colors.red : AppColors.primary),
        title: Text(
          title,
          style: TextStyle(
            color: isWarning ? Colors.red : AppColors.textPrimary,
          ),
        ),
        subtitle: Text(sub, style: AppStyles.font12GrayMedium),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
        onTap: () {},
      ),
    );
  }
}
