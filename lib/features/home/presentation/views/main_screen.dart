import 'package:flutter/material.dart';
import 'package:servicenear/features/home/presentation/views/home_view.dart';
import 'package:servicenear/features/home/presentation/views/profile_view.dart';

import 'package:servicenear/features/home/presentation/widgets/floating_bottom_nav.dart';

import '../../../../common/entities/app_user.dart';

class MainScreen extends StatefulWidget {
  final AppUser user;
  const MainScreen({super.key, required this.user});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  late final List<Widget> _pages = [
    HomeView(user: widget.user),
    // ChatView(),
    // BookingsView(),
    ProfileView(currentUser: widget.user),
    ProfileView(currentUser: widget.user),
    ProfileView(currentUser: widget.user),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[_currentIndex],

          FloatingBottomNav(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() => _currentIndex = index);
            },
          ),
        ],
      ),
    );
  }
}
