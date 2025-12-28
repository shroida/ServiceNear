import 'package:go_router/go_router.dart';
import 'package:servicenear/presentation/common/core/routes_path.dart';

final GoRouter AppRouter = GoRouter(
  initialLocation: '/',
  routes:[
     GoRoute(
      path: RoutePath.login,
      builder: (context, state) => const LoginScreen(),
    ),
    //  GoRoute(
    //   path: '/',
    //   builder: (context, state) => const HomePage(),
    // ),
  ]

);
