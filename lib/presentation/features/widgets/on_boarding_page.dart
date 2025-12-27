import 'package:flutter/material.dart';
import 'package:servicenear/presentation/features/widgets/on_boarding_item.dart';

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
        // 🔹 Background Image
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              opacity: isActive ? 1 : 0.6,
              child: Image.asset(
                item.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        // 🔹 Gradient Overlay
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
        ),

        // 🔹 Content
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Title
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 400),
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  child: Text(
                    item.title,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 12),
                // Subtitle
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
