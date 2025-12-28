import 'package:go_router/go_router.dart';

final GoRouter AppRouter = GoRouter(
  initialLocation: '/',
  routes:[
     GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    //  GoRoute(
    //   path: '/',
    //   builder: (context, state) => const HomePage(),
    // ),
  ]

);
