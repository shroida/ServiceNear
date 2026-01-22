import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenearnew/common/core/app_colors.dart';
import 'package:servicenearnew/common/widgets/app_styles.dart';
import 'package:servicenearnew/features/auth/presentation/cubit/auth_cubit.dart';

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
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        onPressed: () => register ? authCubit.register() : authCubit.login(),
        child: Text(text, style: AppStyles.font16WhiteSemiBold),
      ),
    );
  }
}
