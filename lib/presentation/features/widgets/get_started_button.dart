import 'package:flutter/material.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: () {
            if (_currentPage == items.length - 1) {
              Navigator.pushReplacementNamed(context, '/login');
            } else {
              _controller.nextPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            }
          },
          child: Text(
            _currentPage == items.length - 1 ? "Get Started" : "Next",
          ),
        ),
      ),
    );
  }
}
