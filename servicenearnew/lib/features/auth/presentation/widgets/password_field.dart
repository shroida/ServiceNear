import 'package:flutter/material.dart';
import 'package:servicenearnew/common/widgets/app_styles.dart';
import 'package:servicenearnew/common/widgets/app_text_form_field.dart';
import 'package:servicenearnew/features/auth/presentation/cubit/auth_cubit.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
    required this.authCubit,
  });

  final AuthCubit authCubit;

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      hintText: 'Password',
      suffixIcon: IconButton(
        icon: Icon(
          authCubit.isPasswordVisible ? Icons.visibility : Icons.visibility_off,
        ),
        onPressed: authCubit.togglePasswordVisibility,
      ),
      hintStyle: AppStyles.font13GrayRegular,
      controller: authCubit.passwordController,
      isObscureText: authCubit.isPasswordVisible,
      validator: (v) => v != null && v.length < 6 ? 'Min 6 chars' : null,
    );
  }
}
