import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/widgets/app_styles.dart';
import 'package:servicenear/features/serviceRequest/domain/entities/service_request.dart';
import 'package:servicenear/features/serviceRequest/presentation/cubit/service_request_cubit.dart';

class RequestDetailsView extends StatelessWidget {
  final ServiceRequest request;

  const RequestDetailsView({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text("Request Details", style: AppStyles.font18WhiteMedium),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// REQUEST CARD
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Service", style: AppStyles.font14GrayRegular),

                  SizedBox(height: 6.h),

                  Text(request.title, style: AppStyles.font18DarkBlueBold),

                  SizedBox(height: 20.h),

                  Text("Description", style: AppStyles.font14GrayRegular),

                  SizedBox(height: 6.h),

                  Text(
                    request.description,
                    style: AppStyles.font15DarkBlueMedium,
                  ),

                  SizedBox(height: 20.h),

                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: AppColors.primary,
                        size: 20.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        request.location ?? "Unknown location",
                        style: AppStyles.font14DarkBlueMedium,
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: AppColors.primary,
                        size: 20.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        request.createdAt.toString(),
                        style: AppStyles.font14DarkBlueMedium,
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  Row(
                    children: [
                      Text("Status:", style: AppStyles.font14GrayRegular),
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: _statusColor(request.status),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          request.status,
                          style: AppStyles.font12BlueRegular.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Spacer(),

            /// CANCEL BUTTON
            SizedBox(
              width: double.infinity,
              height: 55.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.error,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                onPressed: () {
                  _showCancelDialog(context);
                },
                child: Text(
                  "Cancel Request",
                  style: AppStyles.font16WhiteSemiBold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case "pending":
        return AppColors.warning;
      case "accepted":
        return AppColors.success;
      case "cancelled":
        return AppColors.error;
      default:
        return AppColors.info;
    }
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Cancel Request"),
          content: const Text(
            "Are you sure you want to cancel this service request?",
          ),
          actions: [
            TextButton(onPressed: () => context.pop(), child: const Text("No")),
            TextButton(
              onPressed: () {
                context.read<ServiceRequestCubit>().updateRequestStatus(
                  request.id,
                  "cancelled",
                );

                context.pop();
                context.pop();
              },
              child: const Text(
                "Yes, Cancel",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
