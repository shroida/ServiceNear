import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/core/routes_path.dart';
import 'package:servicenear/common/widgets/app_snack_bar.dart';
import 'package:servicenear/common/widgets/app_styles.dart';
import 'package:servicenear/common/widgets/build_shadow_field.dart';
import 'package:servicenear/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:servicenear/features/auth/presentation/cubit/app_auth_state.dart';
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
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthCubit, AppAuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            AppSnackBar.show(
              context,
              message: state.message,
              type: AppSnackBarType.error,
            );
          } else if (state is AuthLoggedIn) {
            context.go(RoutePath.home);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                // 1. Decorative Header
                _buildHeader(),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      SizedBox(height: 30.h),
                      const WelcomeText(),
                      SizedBox(height: 25.h),

                      // 2. Styled Type Selector
                      TypeSelector(
                        selectedType: authCubit.selectedUserType,
                        onTypeChanged: (type) => authCubit.changeUserType(type),
                      ),

                      SizedBox(height: 30.h),

                      Form(
                        key: authCubit.formKey,
                        child: Column(
                          children: [
                            BuildFieldShadow(
                              child: EmailField(authCubit: authCubit),
                            ),
                            SizedBox(height: 16.h),
                            BuildFieldShadow(
                              child: PasswordField(authCubit: authCubit),
                            ),

                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Forgot Password?",
                                  style: AppStyles.font13BlueSemiBold,
                                ),
                              ),
                            ),

                            SizedBox(height: 20.h),

                            state is AuthLoading
                                ? const CircularProgressIndicator()
                                : RegisterLoginButton(
                                    register: false,
                                    authCubit: authCubit,
                                    text: "Login",
                                  ),

                            SizedBox(height: 24.h),
                            const NavigateToLoginRegister(toLogin: false),
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 220.h,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(80.r)),
      ),
      child: Center(
        child: Icon(
          Icons.handyman_rounded,
          size: 80.r,
          color: Colors.white.withValues(alpha: 0.2),
        ),
      ),
    );
  }
}
