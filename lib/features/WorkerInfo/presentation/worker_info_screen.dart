import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:servicenear/common/entities/worker.dart';
import 'package:servicenear/features/WorkerInfo/presentation/widgets/about_widget.dart';
import 'package:servicenear/features/WorkerInfo/presentation/widgets/info_card.dart';
import 'package:servicenear/features/WorkerInfo/presentation/widgets/rating_section.dart';
import 'package:servicenear/features/WorkerInfo/presentation/widgets/worker_info_header.dart';
import 'package:servicenear/common/core/app_colors.dart';

class WorkerInfoScreen extends StatelessWidget {
  final Worker worker;
  const WorkerInfoScreen({super.key, required this.worker});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
        title: Text(
          "${worker.firstName} ${worker.lastName}",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          WorkerInfoHeader(worker: worker),
          SizedBox(height: 20.h),
          AboutSection(
            about:
                'Some Text about the worker. This can be a brief description of their experience, skills, and background.',
          ),

          SizedBox(height: 5.h),
          InfoCard(worker: worker),
          SizedBox(height: 5.h),
          RatingSection(rating: 5.5, reviewsCount: 15),
        ],
      ),
    );
  }
}
