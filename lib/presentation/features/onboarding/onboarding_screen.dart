import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Find Services",
          body: "Find nearby service providers easily.",
          image: Image.asset("assets/onboarding1.png", height: 250),
        ),
        PageViewModel(
          title: "Chat Instantly",
          body: "Chat with workers in real-time.",
          image: Image.asset("assets/onboarding2.png", height: 250),
        ),
        PageViewModel(
          title: "Track Location",
          body: "See providers on the map in real-time.",
          image: Image.asset("assets/onboarding3.png", height: 250),
        ),
      ],
      onDone: () {
        // Navigate to login/home
        Navigator.pushReplacementNamed(context, '/login');
      },
      showSkipButton: true,
      skip: const Text("Skip"),
      next: const Icon(Icons.arrow_forward),
      done: const Text("Done"),
      dotsDecorator: const DotsDecorator(
        activeColor: Colors.blue,
      ),
    );
  }
}
