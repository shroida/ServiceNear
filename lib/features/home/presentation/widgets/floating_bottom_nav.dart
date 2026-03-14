import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenear/common/core/app_colors.dart';

class FloatingBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool isWorker; // Add this to toggle roles

  const FloatingBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.isWorker = false, // Default to customer
  });

  @override
  Widget build(BuildContext context) {
    // Define items based on role
    final List<IconData> icons = isWorker
        ? [
            Icons.dashboard_rounded, // Worker Home/Dashboard
            Icons.message_rounded, // Worker Chats
            Icons.assignment_rounded, // Worker Jobs/Tasks
            Icons.person_rounded, // Worker Profile
          ]
        : [
            Icons.home_rounded, // Customer Home
            Icons.chat_bubble_rounded, // Customer Chats
            Icons.calendar_month_rounded, // Customer Bookings
            Icons.person_rounded, // Customer Profile
          ];

    return Positioned(
      bottom: 20.h,
      left: 20.w,
      right: 20.w,
      child: Container(
        height: 70.h, // Slightly taller for better touch targets
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(35.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.15),
              blurRadius: 25,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(icons.length, (index) {
            return _NavItem(
              icon: icons[index],
              index: index,
              currentIndex: currentIndex,
              onTap: onTap,
              // Label for better UX (Optional, but makes it "Awesome")
              label: _getLabel(index, isWorker),
            );
          }),
        ),
      ),
    );
  }

  String _getLabel(int index, bool isWorker) {
    if (isWorker) {
      return ['Stats', 'Chats', 'Jobs', 'Profile'][index];
    }
    return ['Home', 'Chats', 'Orders', 'Profile'][index];
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final int index;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final String label;

  const _NavItem({
    required this.icon,
    required this.index,
    required this.currentIndex,
    required this.onTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = index == currentIndex;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutBack,
        padding: EdgeInsets.symmetric(horizontal: isSelected ? 16.w : 12.w),
        height: 50.h,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : Colors.grey[400],
              size: 24.sp,
            ),
            if (isSelected) ...[
              SizedBox(width: 8.w),
              Text(
                label,
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
