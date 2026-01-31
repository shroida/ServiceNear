import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenear/common/core/images.dart';
import 'package:servicenear/common/entities/app_user.dart';
import 'package:servicenear/common/core/app_colors.dart';

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
          colors: [AppColors.primary, AppColors.primary.withOpacity(0.7)],
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
              ElevatedButton(onPressed: () {}, child: Text('Message')),
              SizedBox(width: 6.w),
              Text(
                user.phoneNubmer,
                style: TextStyle(fontSize: 13.sp, color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
