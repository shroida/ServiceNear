import 'package:flutter/material.dart';
import 'package:servicenear/presentation/features/onboarding/onboarding_screen.dart';

class SearchNear extends StatelessWidget {
  const SearchNear({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: OnBoardingScreen(),
      ),
    );
  }
}
