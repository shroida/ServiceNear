import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenearnew/common/core/app_router.dart';
import 'package:servicenearnew/common/core/supabase_client.dart';
import 'package:servicenearnew/search_near.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SupabaseManager.init();
  final appRouter = AppRouter();

  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => SearchNear(appRouter: appRouter.router),
    ),
  );
}
