import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:servicenear/common/core/di/injection.dart';
import 'package:servicenear/common/core/routes_path.dart';
import 'package:servicenear/common/entities/worker.dart';

import 'package:servicenear/features/auth/presentation/cubit/auth_cubit.dart';

import 'package:servicenear/features/auth/presentation/pages/login_screen.dart';
import 'package:servicenear/features/auth/presentation/pages/register_screen.dart';
import 'package:servicenear/features/chat/presentation/chat_screen.dart';

import 'package:servicenear/features/home/presentation/cubit/home_cubit.dart';
import 'package:servicenear/features/home/presentation/home_screen.dart';
import 'package:servicenear/features/home/presentation/views/workers_view.dart';
import 'package:servicenear/features/onboarding/pages/onboarding_screen.dart';
import 'package:servicenear/features/WorkerInfo/presentation/worker_info_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppRouter {
  late final GoRouter router = GoRouter(
    initialLocation: RoutePath.onBoarding,
    redirect: (context, state) {
      final session = Supabase.instance.client.auth.currentSession;
      final isLoggedIn = session != null;
      final isOnboarding = state.matchedLocation == RoutePath.onBoarding;
      final isRegister = state.matchedLocation == RoutePath.register;
      final isHome = state.matchedLocation == RoutePath.home;

      if (isLoggedIn && (isOnboarding || isRegister)) {
        return RoutePath.home;
      }

      if (!isLoggedIn && isHome) {
        return RoutePath.onBoarding;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: RoutePath.login,
        builder: (context, state) => BlocProvider(
          create: (_) => AuthCubit(sl()),
          child: const LoginScreen(),
        ),
      ),

      GoRoute(
        path: RoutePath.register,
        builder: (context, state) => BlocProvider(
          create: (_) => AuthCubit(sl()),
          child: const RegisterScreen(),
        ),
      ),

      GoRoute(
        path: RoutePath.chat,

        builder: (context, state) =>
            ChatScreen(chatSubtitle: state.extra as String, chatTitle: 'Chat'),
      ),

      GoRoute(
        path: RoutePath.onBoarding,
        builder: (context, state) => const OnBoardingScreen(),
      ),

      GoRoute(
        path: RoutePath.workerInfo,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          final Worker worker = data['user'] as Worker;
          return WorkerInfoScreen(worker: worker);
        },
      ),

      ShellRoute(
        builder: (context, state, child) {
          return BlocProvider(
            create: (_) => HomeCubit(sl())..fetchWorkers(),
            child: child,
          );
        },
        routes: [
          GoRoute(path: RoutePath.home, builder: (_, _) => const HomeScreen()),
          GoRoute(
            path: RoutePath.workers,
            builder: (_, _) => const WorkersView(),
          ),
        ],
      ),
    ],
  );
}
