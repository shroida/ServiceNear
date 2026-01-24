import 'package:flutter/material.dart';
import 'package:servicenear/features/auth/domain/entities/app_user.dart';
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
      appBar: AppBar(
        title: Text(
          'Welcome ${'${userData!.firstName} ${userData!.lastName}'}',
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Type ${userData!.userType}'),
            Text('ID:   ${userData!.id}'),
            Text('ID:   ${userData!.createdAt}'),
            Text('ID:   ${userData!.email}'),
          ],
        ),
      ),
    );
  }
}
