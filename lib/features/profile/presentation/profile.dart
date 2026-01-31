import 'package:flutter/material.dart';
import 'package:servicenear/common/entities/app_user.dart';

class Profile extends StatefulWidget {
  final AppUser user;
  const Profile({super.key, required this.user});

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
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
