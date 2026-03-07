import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/core/di/injection.dart';
import 'package:servicenear/common/core/images.dart';
import 'package:servicenear/common/core/routes_path.dart';
import 'package:servicenear/common/entities/worker.dart';
import 'package:servicenear/common/widgets/app_styles.dart';
import 'package:servicenear/features/auth/domain/repositories/user_repository.dart';

class WorkerInfoHeader extends StatelessWidget {
  final Worker worker;
  const WorkerInfoHeader({super.key, required this.worker});

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
                getWorkerImage(worker.specialty),
                width: 60.w,
                height: 60.h,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            '${worker.firstName} ${worker.lastName}',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            worker.email,
            style: TextStyle(fontSize: 13.sp, color: Colors.white70),
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () async {
                  final currentUser = await sl<UserRepository>()
                      .getCurrentUserData();
                  if (!context.mounted || currentUser == null) return;
                  context.push(RoutePath.chat, extra: worker.id);
                },
                icon: const Icon(
                  Icons.chat_bubble_outline_rounded,
                  size: 20,
                  color: AppColors.textOnPrimary,
                ),
                label: Text('Message', style: AppStyles.font16WhiteSemiBold),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 14.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  elevation: 6,
                  shadowColor: AppColors.shadow,
                  textStyle: AppStyles.font16WhiteSemiBold,
                ),
              ),
              SizedBox(width: 12.w),
              InkWell(
                borderRadius: BorderRadius.circular(14.r),
                onTap: () {
                  if (!context.mounted) return;
                  context.push(
                    RoutePath.addRequest,
                    extra: {
                      'workerId': worker.id,
                      'phone': worker.phoneNubmer ?? '',
                    },
                  );
                },
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
                        worker.phoneNubmer ?? 'Not provided',
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
}
