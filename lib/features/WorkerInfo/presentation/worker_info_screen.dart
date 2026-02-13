import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenear/features/WorkerInfo/presentation/widgets/about_widget.dart';
import 'package:servicenear/features/WorkerInfo/presentation/widgets/info_card.dart';
import 'package:servicenear/features/WorkerInfo/presentation/widgets/rating_section.dart';
import 'package:servicenear/features/WorkerInfo/presentation/widgets/worker_info_header.dart';
import 'package:servicenear/common/entities/app_user.dart';
import 'package:servicenear/common/core/app_colors.dart';

class WorkerInfoScreen extends StatelessWidget {
  final AppUser user;
  final String specialty;
  const WorkerInfoScreen({
    super.key,
    required this.user,
    required this.specialty,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          WorkerInfoHeader(user: user, specialty: specialty),
          SizedBox(height: 20.h),
          AboutSection(
            about:
                'Some Text about the worker. This can be a brief description of their experience, skills, and background.',
          ),

          SizedBox(height: 5.h),
          InfoCard(user: user, specialty: specialty),
          SizedBox(height: 5.h),
          RatingSection(rating: 5.5, reviewsCount: 15),
        ],
      ),
    );
  }
}
