import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:servicenear/common/core/routes_path.dart';
import 'package:servicenear/features/auth/domain/entities/app_user.dart';
import 'package:servicenear/features/home/presentation/widgets/custom_appbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:servicenear/features/auth/domain/repositories/user_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AppUser? userData;
  final userRepository = UserRepository(Supabase.instance.client);

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final data = await userRepository.getCurrentUserData();
    if (!mounted) return;
    setState(() {
      userData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userData == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      drawer: const Drawer(),
      appBar: AwesomeAppBar(
        user: userData!,
        onMenuTap: () => Scaffold.of(context).openDrawer(),
        onNotificationTap: () {},
      ),
      body: Center(
        child: Column(
          children: [
            Text('Type ${userData!.userType}'),
            Text('ID:   ${userData!.id}'),
            Text('ID:   ${userData!.createdAt}'),
            Text('ID:   ${userData!.email}'),
            ElevatedButton(
              onPressed: () async {
                await userRepository.logout();
                if (!context.mounted) return;
                context.go(RoutePath.login);
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
