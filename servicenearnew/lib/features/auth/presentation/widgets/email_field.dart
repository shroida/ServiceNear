
import 'package:flutter/material.dart';
import 'package:servicenearnew/common/widgets/app_styles.dart';
import 'package:servicenearnew/common/widgets/app_text_form_field.dart';
import 'package:servicenearnew/features/auth/presentation/cubit/auth_cubit.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    super.key,
    required this.authCubit,
  });

  final AuthCubit authCubit;

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      hintText: 'Email',
      hintStyle: AppStyles.font13GrayRegular,
      controller: authCubit.emailController,
      validator: (v) => v == null || !v.contains('@')
          ? 'Enter valid email'
          : null,
    );
  }
}
