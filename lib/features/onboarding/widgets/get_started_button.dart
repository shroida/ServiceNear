import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/core/routes_path.dart';
import 'package:servicenear/features/onboarding/widgets/on_boarding_item.dart';

class GetStartedButton extends StatefulWidget {
  const GetStartedButton({
    super.key,
    required int currentPage,
    required this.items,
    required PageController controller,
  }) : _currentPage = currentPage,
       _controller = controller;

  final int _currentPage;
  final List<OnboardingItem> items;
  final PageController _controller;

  @override
  State<GetStartedButton> createState() => _GetStartedButtonState();
}

class _GetStartedButtonState extends State<GetStartedButton> {
  @override
  Widget build(BuildContext context) {
    final bool isLast = widget._currentPage == widget.items.length - 1;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: () {
            if (isLast) {
              context.go(RoutePath.register);
            } else {
              widget._controller.nextPage(
                duration: const Duration(milliseconds: 600),
                curve: Curves.fastOutSlowIn,
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
