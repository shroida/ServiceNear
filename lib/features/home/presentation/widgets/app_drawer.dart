import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:servicenear/common/core/routes_path.dart';
import 'package:servicenear/features/auth/domain/repositories/user_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final userRepository = UserRepository(Supabase.instance.client);

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            DrawerHeader(
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Row(
                children: const [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.home_repair_service, size: 28),
                  ),
                  SizedBox(width: 12),
                  Text(
                    'ServiceNear',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            DrawerItem(
              icon: Icons.person_outline,
              title: 'Profile',
              onTap: () {
                Navigator.pop(context);
                // context.go(RoutePath.profile); // later
              },
            ),

            DrawerItem(
              icon: Icons.settings_outlined,
              title: 'Settings',
              onTap: () {
                Navigator.pop(context);
                // context.go(RoutePath.settings); // later
              },
            ),

            const Spacer(),

            const Divider(),

            // ================= LOGOUT =================
            DrawerItem(
              icon: Icons.logout,
              title: 'Logout',
              color: Colors.red,
              onTap: () async {
                Navigator.pop(context);

                await userRepository.logout();
                if (!context.mounted) return;

                context.go(RoutePath.login);
              },
            ),
          ],
        ),
      ),
    );
  }
}
