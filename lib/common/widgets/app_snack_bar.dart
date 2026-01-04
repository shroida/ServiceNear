import 'package:flutter/material.dart';

enum AppSnackBarType {
  success,
  error,
  warning,
}

class AppSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    required AppSnackBarType type,
  }) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: _backgroundColor(type),
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      duration: const Duration(seconds: 3),
      content: Row(
        children: [
          Icon(
            _icon(type),
            color: Colors.white,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static Color _backgroundColor(AppSnackBarType type) {
    switch (type) {
      case AppSnackBarType.success:
        return const Color(0xFF2ECC71); // Green
      case AppSnackBarType.error:
        return const Color(0xFFE74C3C); // Red
      case AppSnackBarType.warning:
        return const Color(0xFFF39C12); // Orange
    }
  }

  static IconData _icon(AppSnackBarType type) {
    switch (type) {
      case AppSnackBarType.success:
        return Icons.check_circle_rounded;
      case AppSnackBarType.error:
        return Icons.error_rounded;
      case AppSnackBarType.warning:
        return Icons.warning_amber_rounded;
    }
  }
}
