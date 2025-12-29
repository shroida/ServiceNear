import 'package:flutter/material.dart';
import 'package:servicenear/presentation/common/widgets/app_styles.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome Back',
          style: AppStyles.font24BlueBold,
        ),
      ],
    ))));
  }
}
