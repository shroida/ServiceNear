import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/widgets/app_styles.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({
    super.key,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
  });

  final String name;
  final String lastMessage;
  final DateTime time;
  final int unreadCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 28.r,
                backgroundColor: AppColors.primaryLight,
                child: Text("A", style: AppStyles.font16WhiteSemiBold),
              ),
              Positioned(
                bottom: 2,
                right: 2,
                child: Container(
                  width: 12.w,
                  height: 12.w,
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(width: 14.w),

          /// Name + Message
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppStyles.font18DarkGreyMedium),
                SizedBox(height: 4.h),
                Text(
                  lastMessage,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.font14GrayRegular,
                ),
              ],
            ),
          ),

          /// Time + Unread
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${time.hour}:${time.minute} ${time.hour >= 12 ? 'PM' : 'AM'}",
                style: AppStyles.font12GrayRegular,
              ),
              SizedBox(height: 6.h),

              /// Unread Badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  "$unreadCount",
                  style: AppStyles.font12BlueRegular.copyWith(
                    color: Colors.white,
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
