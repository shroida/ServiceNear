import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<_OnboardingItem> items = [
    _OnboardingItem(
      title: "Find Services",
      subtitle: "Find nearby service providers easily.",
      icon: Icons.handyman,
    ),
    _OnboardingItem(
      title: "Chat Instantly",
      subtitle: "Chat with workers in real-time.",
      icon: Icons.chat_bubble_outline,
    ),
    _OnboardingItem(
      title: "Track Location",
      subtitle: "See providers on the map live.",
      icon: Icons.location_on_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 🔹 Pages
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: items.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  return _OnboardingContent(item: items[index]);
                },
              ),
            ),

            // 🔹 Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                items.length,
                (index) => _Dot(isActive: index == _currentPage),
              ),
            ),

            const SizedBox(height: 24),

            // 🔹 Button
            Padding(
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
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _OnboardingContent extends StatelessWidget {
  final _OnboardingItem item;

  const _OnboardingContent({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            item.icon,
            size: 120,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(height: 32),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              item.title,
              key: ValueKey(item.title),
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            item.subtitle,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final bool isActive;

  const _Dot({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? Theme.of(context).primaryColor : Colors.grey.shade400,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

class _OnboardingItem {
  final String title;
  final String subtitle;
  final IconData icon;

  _OnboardingItem({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}
