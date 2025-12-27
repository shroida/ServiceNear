import 'package:flutter/widgets.dart';
import 'package:servicenear/presentation/features/widgets/on_boarding_item.dart';

class OnboardingPageView extends StatelessWidget {
  final OnboardingItem item;

  const OnboardingPageView({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(item.icon, size: 120),
          const SizedBox(height: 24),
          Text(
            item.title,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(item.subtitle),
        ],
      ),
    );
  }
}
