import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/widgets/app_styles.dart';
import 'package:servicenear/features/auth/presentation/cubit/auth_cubit.dart';

class RegisterLoginButton extends StatelessWidget {
  const RegisterLoginButton({
    super.key,
    required this.authCubit,
    required this.text,
    required this.register,
  });
  final bool register;
  final String text;
  final AuthCubit authCubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        onPressed: () => register ? authCubit.register(
          email: authCubit.emailController.text.trim(),
          password: authCubit.passwordController.text.trim(),
          firstName: authCubit.firstNameController.text.trim(),
          lastName: authCubit.lastNameController.text.trim(),
          latitude: authCubit.latitude,
          longitude: authCubit.longitude,
          phone: authCubit.phoneController.text.trim(),
          address: authCubit.addressController.text.trim(),
          about: authCubit.aboutController.text.trim(),
        ) : authCubit.login(
          email: authCubit.emailController.text.trim(),
          password: authCubit.passwordController.text.trim()
        ),
        child: Text(
          text,
          style: AppStyles.font16WhiteSemiBold.copyWith(letterSpacing: 1.1),
        ),
      ),
    );
  }
}
