import 'package:flutter/material.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/features/onboarding/widgets/on_boarding_item.dart';

class DotsWidget extends StatelessWidget {
  const DotsWidget({
    super.key,
    required this.items,
    required int currentPage,
  }) : _currentPage = currentPage;

  final List<OnboardingItem> items;
  final int _currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        items.length,
        (index) => Dot(isActive: index == _currentPage),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final bool isActive;

  const Dot({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : Colors.grey.shade400,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
