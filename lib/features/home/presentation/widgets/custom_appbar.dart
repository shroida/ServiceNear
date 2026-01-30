import 'package:flutter/material.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/entities/app_user.dart';

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
      automaticallyImplyLeading: false,

      title: Row(
        children: [
          const SizedBox(width: 8),

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
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Welcome',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                "${user.firstName} ${user.lastName}",
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
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_none, color: Colors.black),
              onPressed: onNotificationTap,
            ),
            Positioned(
              right: 12,
              top: 12,
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

        IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: onMenuTap,
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
