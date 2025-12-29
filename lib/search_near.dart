import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:servicenear/presentation/common/core/app_colors.dart';

class SearchNear extends StatelessWidget {
  const SearchNear({
    super.key,
    required this.appRouter,
  });

  final GoRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'Service Near',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
    );
  }
}
