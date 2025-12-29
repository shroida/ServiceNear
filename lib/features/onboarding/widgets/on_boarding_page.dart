import 'package:flutter/material.dart';
import 'package:servicenear/features/onboarding/widgets/on_boarding_item.dart';

class OnboardingPageView extends StatelessWidget {
  final OnboardingItem item;
  final bool isActive;

  const OnboardingPageView({
    super.key,
    required this.item,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 400),
            opacity: isActive ? 1 : 0.6,
            child: Image.asset(
              item.image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 400),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  child: Text(
                    item.title,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 12),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: isActive ? 1 : 0.6,
                  child: Text(
                    item.subtitle,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
