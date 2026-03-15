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
    bool hasUnread = unreadCount > 0;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: hasUnread
            ? AppColors.primary.withValues(alpha: 0.04)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          _buildModernAvatar(),

          SizedBox(width: 14.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: AppStyles.font16DarkBlueBold.copyWith(
                        fontWeight: hasUnread
                            ? FontWeight.bold
                            : FontWeight.w600,
                      ),
                    ),
                    Text(
                      _formatDateTime(time),
                      style: AppStyles.font12GrayMedium.copyWith(
                        color: hasUnread
                            ? AppColors.primary
                            : Colors.grey.shade500,
                        fontWeight: hasUnread
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        lastMessage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.font14GrayRegular.copyWith(
                          color: hasUnread
                              ? Colors.black87
                              : Colors.grey.shade600,
                        ),
                      ),
                    ),
                    if (hasUnread) _buildUnreadBadge(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernAvatar() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                AppColors.primary,
                AppColors.primary.withValues(alpha: 0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 28.r,
            backgroundColor: Colors.transparent,
            child: Text(
              name.isNotEmpty ? name[0].toUpperCase() : "?",
              style: AppStyles.font18WhiteMedium,
            ),
          ),
        ),
        Positioned(
          bottom: 2,
          right: 2,
          child: Container(
            width: 14.w,
            height: 14.w,
            decoration: BoxDecoration(
              color: const Color(0xFF4ADE80),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUnreadBadge() {
    return Container(
      margin: EdgeInsets.only(left: 8.w),
      padding: EdgeInsets.all(7.w),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      constraints: BoxConstraints(minWidth: 20.w, minHeight: 20.w),
      child: Center(
        child: Text(
          "$unreadCount",
          style: TextStyle(
            color: Colors.white,
            fontSize: 10.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    if (dateTime.day == now.day &&
        dateTime.month == now.month &&
        dateTime.year == now.year) {
      return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
    }
    return "${dateTime.day}/${dateTime.month}";
  }
}
