import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenear/common/core/app_router.dart';
import 'package:servicenear/common/core/di/injection.dart';
import 'package:servicenear/common/core/supabase_client.dart';
import 'package:servicenear/features/auth/presentation/cubit/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();
  await SupabaseManager.init();

  final appRouter = AppRouter();

  runApp(
    BlocProvider(
      create: (_) => sl<AuthCubit>(), // Provide AuthCubit here
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) =>
            MaterialApp.router(routerConfig: appRouter.router),
      ),
    ),
  );
}
