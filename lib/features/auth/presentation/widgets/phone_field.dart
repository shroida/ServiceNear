import 'package:flutter/material.dart';
import 'package:servicenear/common/widgets/app_styles.dart';
import 'package:servicenear/common/widgets/app_text_form_field.dart';
import 'package:servicenear/features/auth/presentation/cubit/auth_cubit.dart';

class PhoneField extends StatelessWidget {
  const PhoneField({
    super.key,
    required this.authCubit,
  });

  final AuthCubit authCubit;

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      hintText: 'Phone Number',
      hintStyle: AppStyles.font13GrayRegular,
      controller: authCubit.phoneController,
      validator: (v) => v == null || v.isEmpty ? 'Enter phone' : null,
    );
  }
}
