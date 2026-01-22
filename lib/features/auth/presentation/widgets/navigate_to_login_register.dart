// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:servicenear/common/core/routes_path.dart';
import 'package:servicenear/common/widgets/app_styles.dart';

class NavigateToLoginRegister extends StatelessWidget {
  const NavigateToLoginRegister({super.key, required this.toLogin});

  final bool toLogin;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('I have an account,', style: AppStyles.font14DarkRegular),
        SizedBox(width: 5.w),
        GestureDetector(
          onTap: () {
            toLogin
                ? context.go(RoutePath.login)
                : context.go(RoutePath.register);
          },
          child: Text('login', style: AppStyles.font14BlueSemiBold),
        ),
      ],
    );
  }
}
