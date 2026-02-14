import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/entities/app_user.dart';
import 'package:servicenear/common/entities/worker.dart';
import 'package:servicenear/common/widgets/app_styles.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key, required this.currentUser});
  final AppUser currentUser;

  @override
  Widget build(BuildContext context) {
    final isWorker = currentUser is Worker;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context, isWorker),
            SizedBox(height: 70.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  _buildBasicInfoCard(),
                  SizedBox(height: 20.h),
                  if (isWorker) _buildWorkerSection(currentUser as Worker),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= HEADER =================

  Widget _buildHeader(BuildContext context, bool isWorker) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 220.h,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.primaryDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40.r),
              bottomRight: Radius.circular(40.r),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 60.h),
            child: Column(
              children: [
                Text(
                  isWorker ? "Worker Profile" : "User Profile",
                  style: AppStyles.font18WhiteMedium,
                ),
              ],
            ),
          ),
        ),

        // Avatar
        Positioned(
          bottom: -50.h,
          left: 0,
          right: 0,
          child: CircleAvatar(
            radius: 55.r,
            backgroundColor: AppColors.scaffoldBackground,
            child: CircleAvatar(
              radius: 50.r,
              backgroundColor: AppColors.primaryLight,
              child: Text(
                currentUser.firstName[0].toUpperCase(),
                style: TextStyle(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ================= BASIC INFO =================

  Widget _buildBasicInfoCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            "${currentUser.firstName} ${currentUser.lastName}",
            style: AppStyles.font18DarkBlueBold,
          ),
          SizedBox(height: 8.h),
          Text(currentUser.email, style: AppStyles.font14GrayRegular),
          SizedBox(height: 12.h),
          Divider(color: AppColors.divider),
          SizedBox(height: 12.h),
          _infoRow(
            Icons.location_on,
            "Location",
            "${currentUser.location.latitude}, ${currentUser.location.longitude}",
          ),
          SizedBox(height: 10.h),
          _infoRow(
            Icons.calendar_today,
            "Joined",
            "${currentUser.createdAt.year}-${currentUser.createdAt.month}-${currentUser.createdAt.day}",
          ),
        ],
      ),
    );
  }

  // ================= WORKER SECTION =================

  Widget _buildWorkerSection(Worker worker) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Professional Info", style: AppStyles.font18DarkBlueSemiBold),
          SizedBox(height: 16.h),

          _infoRow(
            Icons.work,
            "Specialty",
            worker.specialty ?? "Not specified",
          ),
          SizedBox(height: 10.h),
          _infoRow(
            Icons.star,
            "Rating",
            "${worker.rating} (${worker.reviewsCount} reviews)",
          ),
          SizedBox(height: 10.h),
          _infoRow(Icons.phone, "Phone", worker.phoneNubmer ?? "Not provided"),
          SizedBox(height: 10.h),
          _infoRow(Icons.home, "Address", worker.address),

          if (worker.about != null && worker.about!.isNotEmpty) ...[
            SizedBox(height: 16.h),
            Divider(color: AppColors.divider),
            SizedBox(height: 12.h),
            Text("About", style: AppStyles.font14BlueSemiBold),
            SizedBox(height: 8.h),
            Text(worker.about!, style: AppStyles.font14GrayRegular),
          ],
        ],
      ),
    );
  }

  // ================= INFO ROW =================

  Widget _infoRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(icon, color: AppColors.primary, size: 18.sp),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppStyles.font12GrayMedium),
              SizedBox(height: 4.h),
              Text(value, style: AppStyles.font14DarkRegular),
            ],
          ),
        ),
      ],
    );
  }
}
