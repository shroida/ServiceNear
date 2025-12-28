import 'package:go_router/go_router.dart';
import 'package:servicenear/presentation/common/core/routes_path.dart';
import 'package:servicenear/presentation/features/login/pages/login_screen.dart';
import 'package:servicenear/presentation/features/onboarding/pages/onboarding_screen.dart';

final GoRouter appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: RoutePath.login,
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: RoutePath.onBoarding,
    builder: (context, state) => const OnBoardingScreen(),
  ),
  //  GoRoute(
  //   path: '/',
  //   builder: (context, state) => const HomePage(),
  // ),
]);
