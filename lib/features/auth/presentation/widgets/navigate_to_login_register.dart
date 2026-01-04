import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:servicenear/common/core/routes_path.dart';
import 'package:servicenear/common/widgets/app_styles.dart';

class NavigateToLoginScreen extends StatelessWidget {
  const NavigateToLoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'I have an account,',
          style: AppStyles.font14DarkRegular,
        ),
        SizedBox(width: 5.w),
        GestureDetector(
          onTap: () => context.go(RoutePath.login),
          child: Text(
            'login',
            style: AppStyles.font14BlueSemiBold,
          ),
        ),
      ],
    );
  }
}
