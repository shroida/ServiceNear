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
    final isWorker = currentUser.userType.name == 'worker';

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD), // Softer background
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context, isWorker),
            SizedBox(height: 60.h), // Adjusted for better spacing
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  _buildProfileSummaryCard(isWorker),
                  SizedBox(height: 20.h),
                  if (isWorker) ...[
                    _buildStatsRow(currentUser as Worker),
                    SizedBox(height: 20.h),
                    _buildProfessionalCard(currentUser as Worker),
                  ],
                  _buildSettingsSection(context),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isWorker) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Background Gradient with Curve
        Container(
          height: 190.h,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.primaryDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50.r),
              bottomRight: Radius.circular(50.r),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    isWorker ? "Professional Profile" : "My Account",
                    style: AppStyles.font18WhiteMedium.copyWith(
                      letterSpacing: 1.1,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.edit_note_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                    onPressed: () {}, // Navigate to Edit Profile
                  ),
                ],
              ),
            ),
          ),
        ),

        // Floating Avatar with Glow Effect
        Positioned(
          bottom: -50.h,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: EdgeInsets.all(4.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.2), // Outer Ring
              ),
              child: Container(
                padding: EdgeInsets.all(4.r),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white, // Inner Border
                ),
                child: CircleAvatar(
                  radius: 50.r,
                  backgroundColor: AppColors.primaryLight,
                  child: Text(
                    currentUser.firstName[0].toUpperCase(),
                    style: TextStyle(
                      fontSize: 36.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileSummaryCard(bool isWorker) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          Text(
            "${currentUser.firstName} ${currentUser.lastName}",
            style: AppStyles.font20DarkBlueBold,
          ),
          SizedBox(height: 4.h),
          Text(currentUser.email, style: AppStyles.font14GrayRegular),
          if (isWorker) ...[
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                (currentUser as Worker).specialty ?? "Service Provider",
                style: AppStyles.font13BlueSemiBold,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatsRow(Worker worker) {
    return Row(
      children: [
        _statItem(Icons.star_rounded, "Rating", "${worker.rating}"),
        SizedBox(width: 15.w),
        _statItem(Icons.reviews_rounded, "Reviews", "${worker.reviewsCount}"),
        SizedBox(width: 15.w),
        _statItem(Icons.verified_user_rounded, "Status", "Verified"),
      ],
    );
  }

  Widget _statItem(IconData icon, String label, String value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.h),
        decoration: _cardDecoration(),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 20.sp),
            SizedBox(height: 6.h),
            Text(value, style: AppStyles.font14DarkBlueMedium),
            Text(label, style: AppStyles.font12GrayMedium),
          ],
        ),
      ),
    );
  }

  Widget _buildProfessionalCard(Worker worker) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Business Details", style: AppStyles.font16DarkBlueBold),
              Icon(
                Icons.business_center_rounded,
                color: AppColors.primary.withValues(alpha: 0.5),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _infoRow(
            Icons.phone_iphone_rounded,
            "Phone Number",
            worker.phoneNumber ?? "Not provided",
          ),
          SizedBox(height: 12.h),
          _infoRow(Icons.map_rounded, "Service Address", worker.address),
          if (worker.about != null) ...[
            const Divider(height: 30),
            Text("About Me", style: AppStyles.font14BlueSemiBold),
            SizedBox(height: 6.h),
            Text(
              worker.about!,
              style: AppStyles.font14GrayRegular.copyWith(height: 1.4),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        _settingsTile(Icons.notifications_none_rounded, "Notifications"),
        _settingsTile(Icons.security_rounded, "Privacy & Security"),
        _settingsTile(Icons.help_outline_rounded, "Support Center"),
        _settingsTile(Icons.logout_rounded, "Logout", isDestructive: true),
      ],
    );
  }

  // Helper Methods for UI Consistency
  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 15,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }

  Widget _settingsTile(
    IconData icon,
    String title, {
    bool isDestructive = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: _cardDecoration(),
      child: ListTile(
        leading: Icon(
          icon,
          color: isDestructive ? Colors.redAccent : AppColors.primary,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isDestructive ? Colors.redAccent : AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        onTap: () {},
      ),
    );
  }

  Widget _infoRow(IconData icon, String title, String value) {
    return Row(
      children: [
        CircleAvatar(
          radius: 18.r,
          backgroundColor: AppColors.primary.withValues(alpha: 0.08),
          child: Icon(icon, color: AppColors.primary, size: 16.sp),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppStyles.font12GrayMedium),
              Text(
                value,
                style: AppStyles.font14DarkBlueMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
