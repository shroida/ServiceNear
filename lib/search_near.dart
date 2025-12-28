import 'package:flutter/material.dart';
import 'package:servicenear/presentation/common/core/app_router.dart';

class SearchNear extends StatelessWidget {
  const SearchNear({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
