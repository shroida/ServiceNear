import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:servicenear/common/core/routes_path.dart';
import 'package:servicenear/features/auth/domain/repositories/user_repository.dart';
import 'package:servicenear/features/auth/presentation/cubit/app_auth_state.dart';
import 'package:servicenear/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:servicenear/features/home/presentation/views/main_screen.dart';
import 'package:servicenear/features/home/presentation/widgets/app_drawer.dart';
import 'package:servicenear/features/home/presentation/widgets/custom_appbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:servicenear/common/entities/app_user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final UserRepository userRepository = UserRepository(
    Supabase.instance.client,
  );

  AppUser? currentUser;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await userRepository.getCurrentUserData();
    if (!mounted) return;

    setState(() {
      currentUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return BlocListener<AuthCubit, AppAuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          context.go(RoutePath.onBoarding);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Logged out successfully")),
          );
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: BlocProvider.value(
          value: context.read<AuthCubit>(),
          child: const AppDrawer(),
        ),
        appBar: AwesomeAppBar(
          user: currentUser!,
          onMenuTap: _openEndDrawer,
          onNotificationTap: _onNotificationsPressed,
        ),
        body: MainScreen(user: currentUser!),
      ),
    );
  }

  void _openEndDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  void _onNotificationsPressed() {}
}
