import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:servicenear/common/core/routes_path.dart';
import 'package:servicenear/features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'package:servicenear/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:servicenear/features/auth/domain/repositories/auth_repository.dart';
import 'package:servicenear/features/auth/presentation/cubit/auth_cubit.dart';

import 'package:servicenear/features/auth/presentation/pages/login_screen.dart';
import 'package:servicenear/features/auth/presentation/pages/register_screen.dart';
import 'package:servicenear/features/home/presentation/home_screen.dart';
import 'package:servicenear/features/onboarding/pages/onboarding_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppRouter {
  final AuthRepository _authRepository = AuthRepositoryImpl(
    remoteDataSource: AuthRemoteDataSourceImpl(Supabase.instance.client),
  );
  late final GoRouter router = GoRouter(
    initialLocation: RoutePath.onBoarding,
    routes: [
      GoRoute(
        path: RoutePath.login,
        builder: (context, state) => BlocProvider(
          create: (_) => AuthCubit(_authRepository),
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: RoutePath.register,
        builder: (context, state) => BlocProvider(
          create: (_) => AuthCubit(_authRepository),
          child: const RegisterScreen(),
        ),
      ),
      GoRoute(
        path: RoutePath.onBoarding,
        builder: (context, state) => const OnBoardingScreen(),
      ),
      GoRoute(
        path: RoutePath.home,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
