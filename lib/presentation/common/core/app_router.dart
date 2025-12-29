import 'package:go_router/go_router.dart';
import 'package:servicenear/presentation/common/core/routes_path.dart';
import 'package:servicenear/presentation/features/auth/pages/login_screen.dart';
import 'package:servicenear/presentation/features/auth/pages/register_screen.dart';
import 'package:servicenear/presentation/features/onboarding/pages/onboarding_screen.dart';



class AppRouter {
  late final GoRouter router = GoRouter(
    initialLocation: RoutePath.onBoarding,
    routes: [
      GoRoute(
        path: RoutePath.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RoutePath.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: RoutePath.onBoarding,
        builder: (context, state) => const OnBoardingScreen(),
      ),
    ],
  );
}
