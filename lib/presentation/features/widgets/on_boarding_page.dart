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
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFDFF5EA), Color(0xFFBFF0D3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🔹 Animated Icon
              AnimatedScale(
                scale: isActive ? 1 : 0.8,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutBack,
                child: Icon(
                  item.icon,
                  size: 130,
                  color: Colors.green.shade700,
                ),
              ),

              const SizedBox(height: 32),

              // 🔹 Title
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 400),
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color:
                      isActive ? Colors.green.shade900 : Colors.grey.shade700,
                ),
                child: Text(
                  item.title,
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 12),

              // 🔹 Subtitle
              AnimatedOpacity(
                opacity: isActive ? 1 : 0.5,
                duration: const Duration(milliseconds: 400),
                child: Text(
                  item.subtitle,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade800,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
