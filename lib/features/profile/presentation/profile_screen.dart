import 'package:flutter/material.dart';
import 'package:servicenear/common/entities/app_user.dart';

class ProfileScreen extends StatefulWidget {
  final AppUser user;
  const ProfileScreen({super.key, required this.user});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Profile of ${widget.user.firstName}'),
        Text('Email: ${widget.user.email}'),
        Text('User Type: ${widget.user.userType}'),
      ],
    );
  }
}
