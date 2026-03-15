import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:servicenear/common/core/images.dart';
import 'package:servicenear/common/core/routes_path.dart';
import 'package:servicenear/features/onboarding/widgets/dots_widget.dart';
import 'package:servicenear/features/onboarding/widgets/get_started_button.dart';
import 'package:servicenear/features/onboarding/widgets/on_boarding_item.dart';
import 'package:servicenear/features/onboarding/widgets/on_boarding_page.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<OnboardingItem> items = [
    OnboardingItem(
      title: "Find Services",
      subtitle: "Find nearby service providers easily.",
      image: Assets.plumber,
    ),
    OnboardingItem(
      title: "Chat Instantly",
      subtitle: "Chat with workers in real-time.",
      image: Assets.garage,
    ),
    OnboardingItem(
      title: "Track Location",
      subtitle: "See providers on the map live.",
      image: Assets.supermarket,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Allows image to reach the top
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: items.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) =>
                OnboardingPageView(item: items[index]),
          ),

          // Skip Button
          Positioned(
            top: 50.h,
            right: 20.w,
            child: TextButton(
              onPressed: () => context.go(RoutePath.register),
              child: const Text("Skip", style: TextStyle(color: Colors.white)),
            ),
          ),

          // Bottom Controls
          Positioned(
            bottom: 40.h,
            left: 0,
            right: 0,
            child: Column(
              children: [
                DotsWidget(items: items, currentPage: _currentPage),
                SizedBox(height: 32.h),
                GetStartedButton(
                  currentPage: _currentPage,
                  items: items,
                  controller: _controller,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
