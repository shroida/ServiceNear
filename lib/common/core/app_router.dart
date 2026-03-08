import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:servicenear/common/core/di/injection.dart';
import 'package:servicenear/common/core/routes_path.dart';
import 'package:servicenear/common/entities/app_user.dart';
import 'package:servicenear/common/entities/worker.dart';
import 'package:servicenear/features/auth/presentation/cubit/app_auth_state.dart';

import 'package:servicenear/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:servicenear/features/auth/presentation/pages/login_screen.dart';
import 'package:servicenear/features/auth/presentation/pages/register_screen.dart';

import 'package:servicenear/features/chat/presentation/chat_screen.dart';
import 'package:servicenear/features/chat/presentation/cubit/chat_cubit.dart';

import 'package:servicenear/features/home/presentation/cubit/home_cubit.dart';
import 'package:servicenear/features/home/presentation/home_screen.dart';
import 'package:servicenear/features/home/presentation/views/profile_view.dart';
import 'package:servicenear/features/home/presentation/views/workers_view.dart';

import 'package:servicenear/features/onboarding/pages/onboarding_screen.dart';
import 'package:servicenear/features/WorkerInfo/presentation/worker_info_screen.dart';

import 'package:servicenear/features/serviceRequest/domain/entities/service_request.dart';
import 'package:servicenear/features/serviceRequest/presentation/add_request_screen.dart';
import 'package:servicenear/features/serviceRequest/presentation/cubit/service_request_cubit.dart';
import 'package:servicenear/features/serviceRequest/presentation/widgets/request_details_view.dart';

class AppRouter {
  late final GoRouter router = GoRouter(
    initialLocation: RoutePath.onBoarding,

    /// ---------------- REDIRECT LOGIC ----------------
    redirect: (context, state) {
      // Read authentication state from AuthCubit
      final authState = context.read<AuthCubit>().state;
      final bool isLoggedIn = authState is AuthAuthenticated;

      final bool isOnboarding = state.matchedLocation == RoutePath.onBoarding;
      final bool isRegister = state.matchedLocation == RoutePath.register;
      final bool isHome = state.matchedLocation == RoutePath.home;

      /// If user logged in → prevent going to onboarding/register
      if (isLoggedIn && (isOnboarding || isRegister)) {
        return RoutePath.home;
      }

      /// If user not logged in → prevent entering home
      if (!isLoggedIn && isHome) {
        return RoutePath.onBoarding;
      }

      return null;
    },

    routes: [
      /// ---------------- LOGIN ----------------
      GoRoute(
        path: RoutePath.login,
        builder: (context, state) {
          return BlocProvider(
            create: (_) => AuthCubit(sl(), sl()),
            child: const LoginScreen(),
          );
        },
      ),

      /// ---------------- REGISTER ----------------
      GoRoute(
        path: RoutePath.register,
        builder: (context, state) {
          return BlocProvider(
            create: (_) => AuthCubit(sl(), sl()),
            child: const RegisterScreen(),
          );
        },
      ),

      /// ---------------- CHAT ----------------
      GoRoute(
        path: RoutePath.chat,
        builder: (context, state) {
          final receiverId = state.extra as String?;
          if (receiverId == null) {
            return const Scaffold(
              body: Center(child: Text("Invalid chat receiver")),
            );
          }

          final currentUserId = context.read<AuthCubit>().state.currentUserId;

          return BlocProvider(
            create: (_) => sl<ChatCubit>()
              ..loadMessagesBetweenCustomerAndWorker(currentUserId, receiverId),
            child: ChatScreen(receiverId: receiverId),
          );
        },
      ),

      /// ---------------- ONBOARDING ----------------
      GoRoute(
        path: RoutePath.onBoarding,
        builder: (context, state) => const OnBoardingScreen(),
      ),

      /// ---------------- WORKER INFO ----------------
      GoRoute(
        path: RoutePath.workerInfo,
        builder: (context, state) {
          final data = state.extra;
          if (data is! Map<String, dynamic>) {
            return const Scaffold(
              body: Center(child: Text("Invalid worker data")),
            );
          }

          final Worker worker = data['user'];
          return WorkerInfoScreen(worker: worker);
        },
      ),

      /// ---------------- PROFILE ----------------
      GoRoute(
        path: RoutePath.profile,
        builder: (context, state) {
          final data = state.extra;
          if (data is! Map<String, dynamic>) {
            return const Scaffold(
              body: Center(child: Text("Invalid profile data")),
            );
          }

          final AppUser profile = data['user'];
          return ProfileView(currentUser: profile);
        },
      ),

      /// ---------------- ADD REQUEST ----------------
      GoRoute(
        path: RoutePath.addRequest,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>?;
          final workerId = data?['workerId'] as String?;

          return BlocProvider(
            create: (_) => sl<ServiceRequestCubit>(),
            child: AddRequestScreen(workerId: workerId),
          );
        },
      ),

      /// ---------------- REQUEST DETAILS ----------------
      GoRoute(
        path: RoutePath.requestDetails,
        builder: (context, state) {
          final request = state.extra;
          if (request is! ServiceRequest) {
            return const Scaffold(
              body: Center(child: Text("Invalid request data")),
            );
          }

          return BlocProvider(
            create: (_) => sl<ServiceRequestCubit>(),
            child: RequestDetailsView(request: request),
          );
        },
      ),

      /// ---------------- MAIN APP SHELL ----------------
      ShellRoute(
        builder: (context, state, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => AuthCubit(sl(), sl())),
              BlocProvider(create: (_) => HomeCubit(sl())..fetchWorkers()),
            ],
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: RoutePath.home,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: RoutePath.workers,
            builder: (context, state) => const WorkersView(),
          ),
        ],
      ),
    ],
  );
}
