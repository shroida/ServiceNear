import 'package:flutter/material.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/features/auth/domain/entities/app_user.dart';

class AwesomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppUser user;
  final VoidCallback onMenuTap;
  final VoidCallback onNotificationTap;

  const AwesomeAppBar({
    super.key,
    required this.user,
    required this.onMenuTap,
    required this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    final isCustomer = user.userType.name == 'customer';

    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.black),
        onPressed: onMenuTap,
      ),
      title: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: isCustomer ? AppColors.primary : Colors.orange,
            child: Icon(
              isCustomer ? Icons.person : Icons.handyman,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                user.firstName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_none, color: Colors.black),
              onPressed: onNotificationTap,
            ),
            Positioned(
              right: 10,
              top: 10,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
