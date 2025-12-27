import 'package:flutter/material.dart';
import 'package:servicenear/presentation/common/core/images.dart';
import 'package:servicenear/presentation/features/widgets/dots_widget.dart';
import 'package:servicenear/presentation/features/widgets/get_started_button.dart';
import 'package:servicenear/presentation/features/widgets/on_boarding_item.dart';
import 'package:servicenear/presentation/features/widgets/on_boarding_page.dart';

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
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: items.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  return OnboardingPageView(item: items[index]);
                },
              ),
            ),
            DotsWidget(items: items, currentPage: _currentPage),
            const SizedBox(height: 24),
            GetStartedButton(
                currentPage: _currentPage,
                items: items,
                controller: _controller),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
