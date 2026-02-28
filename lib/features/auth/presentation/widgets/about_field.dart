import 'package:flutter/material.dart';
import 'package:servicenear/common/widgets/app_styles.dart';
import 'package:servicenear/common/widgets/app_text_form_field.dart';
import 'package:servicenear/features/auth/presentation/cubit/auth_cubit.dart';

class AboutFiled extends StatelessWidget {
  const AboutFiled({super.key, required this.authCubit});

  final AuthCubit authCubit;

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      controller: authCubit.aboutController,
      hintText: 'About Yourself',
      validator: (_) => null,
      hintStyle: AppStyles.font13GrayRegular,

      prefixIcon: const Icon(Icons.info_outline),
    );
  }
}
