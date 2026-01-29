import 'package:flutter/material.dart';

import 'package:servicenear/features/auth/domain/entities/app_user.dart';
import 'package:servicenear/features/home/presentation/widgets/app_drawer.dart';
import 'package:servicenear/features/home/presentation/widgets/custom_appbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:servicenear/features/auth/domain/repositories/user_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>(); // <- key
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
      key: scaffoldKey,
      drawer: const AppDrawer(),
      appBar: AwesomeAppBar(
        user: userData!,
        onMenuTap: () {
          scaffoldKey.currentState?.openDrawer();
        },
        onNotificationTap: () {},
      ),
      body: Center(child: Column(children: [
            
          ],
        )),
    );
  }
}
