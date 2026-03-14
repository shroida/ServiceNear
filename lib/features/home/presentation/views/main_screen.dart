import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicenear/common/core/di/injection.dart';
import 'package:servicenear/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:servicenear/features/chat/presentation/views/chat_list_view.dart';
import 'package:servicenear/features/home/presentation/views/home_view.dart';
import 'package:servicenear/features/home/presentation/views/profile_view.dart';
import 'package:servicenear/features/home/presentation/widgets/floating_bottom_nav.dart';
import 'package:servicenear/features/serviceRequest/presentation/cubit/service_request_cubit.dart';
import 'package:servicenear/features/serviceRequest/presentation/views/booking_screen.dart';
import '../../../../common/entities/app_user.dart';

class MainScreen extends StatefulWidget {
  final AppUser user;
  const MainScreen({super.key, required this.user});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  late final ChatCubit _chatCubit;
  late final ServiceRequestCubit _serviceRequestCubit;

  @override
  void initState() {
    super.initState();
    _chatCubit = sl<ChatCubit>()..loadAllChats(widget.user.id);
    _serviceRequestCubit = sl<ServiceRequestCubit>()
      ..fetchBookedServices(widget.user.id);
  }

  @override
  void dispose() {
    _chatCubit.close();
    _serviceRequestCubit.close();

    super.dispose();
  }

  late List<Widget> _pages;

  @override
  Widget build(BuildContext context) {
    _pages = [
      HomeView(user: widget.user),
      BlocProvider.value(
        value: _chatCubit,
        child: ChatListView(currentUserId: widget.user.id, cubit: _chatCubit),
      ),
      BlocProvider.value(value: _serviceRequestCubit, child: BookingsScreen()),
      ProfileView(currentUser: widget.user),
      ProfileView(currentUser: widget.user),
      ProfileView(currentUser: widget.user),
    ];

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: FloatingBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
