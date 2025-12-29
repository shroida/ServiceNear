import 'package:flutter/material.dart';
import 'package:servicenear/presentation/common/core/app_router.dart';
import 'package:servicenear/search_near.dart';

void main() {
  final appRouter = AppRouter();

  runApp(SearchNear(appRouter: appRouter.router));
}
