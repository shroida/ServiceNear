import 'package:flutter/material.dart';
import 'package:servicenear/presentation/common/core/app_colors.dart';
import 'package:servicenear/presentation/features/widgets/on_boarding_item.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({
    super.key,
    required int currentPage,
    required this.items,
    required PageController controller,
  })  : _currentPage = currentPage,
        _controller = controller;

  final int _currentPage;
  final List<OnboardingItem> items;
  final PageController _controller;

  @override
  Widget build(BuildContext context) {
    final bool isLast = _currentPage == items.length - 1;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: () {
            if (isLast) {
              Navigator.pushReplacementNamed(context, '/login');
            } else {
              _controller.nextPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textOnPrimary,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), 
            ),
          ),
          child: Text(
            isLast ? "Get Started" : "Next",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
            ),
          ),
        ),
      ),
    );
  }
}
