import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenear/common/core/images.dart';
import 'package:servicenear/common/entities/app_user.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/widgets/app_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  final AppUser user;
  final String specialty;
  const ProfileScreen({super.key, required this.user, required this.specialty});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _ProfileHeader(user: user, specialty: specialty),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final AppUser user;
  final String specialty;
  const _ProfileHeader({required this.user, required this.specialty});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270.h,
      width: double.infinity,
      padding: EdgeInsets.only(top: 60.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary.withValues(alpha: 0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.r)),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 42.r,
            backgroundColor: Colors.white,
            child: ClipOval(
              child: Image.asset(
                getWorkerImage(specialty),
                width: 60.w,
                height: 60.h,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            '${user.firstName} ${user.lastName}',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            user.email,
            style: TextStyle(fontSize: 13.sp, color: Colors.white70),
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // MESSAGE BUTTON
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Navigate to chat screen
                },
                icon: const Icon(Icons.chat_bubble_outline, size: 18),
                label: const Text('Message'),
                style: ElevatedButton.styleFrom(
                  textStyle: AppStyles.font14DarkRegular,
                  backgroundColor: AppColors.divider,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 12.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  elevation: 4,
                ),
              ),

              SizedBox(width: 12.w),

              // CALL BUTTON
              InkWell(
                borderRadius: BorderRadius.circular(14.r),
                onTap: () => _showCallOptions(context, user.phoneNubmer),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.4),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.phone, size: 18, color: Colors.white),
                      SizedBox(width: 6.w),
                      Text(
                        user.phoneNubmer,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showCallOptions(BuildContext context, String phone) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              SizedBox(height: 20.h),

              ListTile(
                leading: const Icon(Icons.call, color: AppColors.primary),
                title: const Text('Call'),
                onTap: () {
                  Navigator.pop(context);
                  _callNumber(phone);
                },
              ),

              ListTile(
                leading: const Icon(Icons.close),
                title: const Text('Cancel'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _callNumber(String phone) async {
    final uri = Uri.parse('tel:$phone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
