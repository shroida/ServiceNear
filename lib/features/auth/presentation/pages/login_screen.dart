import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/widgets/app_snack_bar.dart';
import 'package:servicenear/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:servicenear/features/auth/presentation/cubit/auth_state.dart';
import 'package:servicenear/features/auth/presentation/widgets/email_field.dart';
import 'package:servicenear/features/auth/presentation/widgets/navigate_to_login_register.dart';
import 'package:servicenear/features/auth/presentation/widgets/password_field.dart';
import 'package:servicenear/features/auth/presentation/widgets/regisgter_button.dart';
import 'package:servicenear/features/auth/presentation/widgets/type_selector.dart';
import 'package:servicenear/features/auth/presentation/widgets/welcome_text.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              AppSnackBar.show(
                context,
                message: 'Registration failed, ${state.message.toString()}',
                type: AppSnackBarType.error,
              );
            } else if (state is AuthSuccess) {
              AppSnackBar.show(
                context,
                message: 'Registered successfully',
                type: AppSnackBarType.success,
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  const WelcomeText(),
                  SizedBox(height: 30.h),
                  TypeSelector(
                    selectedType: authCubit.selectedUserType,
                    onTypeChanged: (type) {
                      authCubit.changeUserType(type);
                    },
                  ),
                  SizedBox(height: 30.h),
                  Form(
                    key: authCubit.formKey,
                    child: Column(
                      children: [
                        EmailField(authCubit: authCubit),
                        SizedBox(height: 16.h),
                        PasswordField(authCubit: authCubit),
                        SizedBox(height: 30.h),
                        state is AuthLoading
                            ? const Center(child: CircularProgressIndicator())
                            : RegisterButton(authCubit: authCubit),
                        SizedBox(height: 20.h),
                        const NavigateToLoginRegister(
                          toLogin: false,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
