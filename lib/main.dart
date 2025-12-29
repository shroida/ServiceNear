import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenear/common/core/app_router.dart';
import 'package:servicenear/search_near.dart';

void main() {
  final appRouter = AppRouter();

  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => SearchNear(
        appRouter: appRouter.router,
      ),
    ),
  );
}
