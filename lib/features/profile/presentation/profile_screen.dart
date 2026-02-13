import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenear/features/profile/presentation/widgets/info_card.dart';
import 'package:servicenear/features/profile/presentation/widgets/profile_header.dart';
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
          ProfileHeader(user: user, specialty: specialty),
          SizedBox(height: 20.h),
          InfoCard(user: user),
          SizedBox(height: 20.h),

          MapSection(user: user),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}
