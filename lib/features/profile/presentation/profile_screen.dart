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
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  _StatsCard(),
                  SizedBox(height: 24.h),
                  _WeekActivity(),
                ],
              ),
            ),
          ),
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
      height: 220.h,
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
        ],
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          _StatRow(
            leftTitle: 'Distance',
            leftValue: '6.1 km',
            rightTitle: 'Calories',
            rightValue: '300',
          ),
          SizedBox(height: 16.h),
          _StatRow(
            leftTitle: 'Elevation',
            leftValue: '492 m',
            rightTitle: 'Time',
            rightValue: '5:30',
          ),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final String leftTitle;
  final String leftValue;
  final String rightTitle;
  final String rightValue;

  const _StatRow({
    required this.leftTitle,
    required this.leftValue,
    required this.rightTitle,
    required this.rightValue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatItem(title: leftTitle, value: leftValue),
        ),
        Expanded(
          child: _StatItem(title: rightTitle, value: rightValue),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String title;
  final String value;

  const _StatItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          title,
          style: TextStyle(fontSize: 12.sp, color: AppColors.textHint),
        ),
      ],
    );
  }
}

class _WeekActivity extends StatelessWidget {
  final days = const ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: days.map((day) {
        return Container(
          width: 40.w,
          height: 40.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: day == 'W' ? AppColors.primary : Colors.grey.shade200,
            shape: BoxShape.circle,
          ),
          child: Text(
            day,
            style: TextStyle(
              fontSize: 13.sp,
              color: day == 'W' ? Colors.white : AppColors.textPrimary,
            ),
          ),
        );
      }).toList(),
    );
  }
}
