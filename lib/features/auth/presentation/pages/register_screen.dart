import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/entities/user_type.dart';
import 'package:servicenear/common/widgets/app_snack_bar.dart';
import 'package:servicenear/common/widgets/app_styles.dart';
import 'package:servicenear/common/widgets/app_text_form_field.dart';
import 'package:servicenear/common/widgets/build_shadow_field.dart';
import 'package:servicenear/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:servicenear/features/auth/presentation/cubit/app_auth_state.dart';
import 'package:servicenear/features/auth/presentation/widgets/about_field.dart';
import 'package:servicenear/features/auth/presentation/widgets/address_field.dart';
import 'package:servicenear/features/auth/presentation/widgets/drop_down_specialties.dart';
import 'package:servicenear/features/auth/presentation/widgets/email_field.dart';
import 'package:servicenear/features/auth/presentation/widgets/first_and_last_name.dart';
import 'package:servicenear/features/auth/presentation/widgets/navigate_to_login_register.dart';
import 'package:servicenear/features/auth/presentation/widgets/password_field.dart';
import 'package:servicenear/features/auth/presentation/widgets/regisgter_button.dart';
import 'package:servicenear/features/auth/presentation/widgets/type_selector.dart';
import 'package:servicenear/features/auth/presentation/widgets/welcome_text.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD), // Softer background
      body: BlocConsumer<AuthCubit, AppAuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            AppSnackBar.show(
              context,
              message: 'Failed: ${state.message}',
              type: AppSnackBarType.error,
            );
          } else if (state is AuthSuccess) {
            AppSnackBar.show(
              context,
              message: 'Registered successfully!',
              type: AppSnackBarType.success,
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      SizedBox(height: 24.h),
                      const WelcomeText(),
                      SizedBox(height: 24.h),

                      // User Type Selection
                      TypeSelector(
                        selectedType: authCubit.selectedUserType,
                        onTypeChanged: (type) => authCubit.changeUserType(type),
                      ),

                      SizedBox(height: 32.h),

                      Form(
                        key: authCubit.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Personal Information",
                              style: AppStyles.font14BlueSemiBold,
                            ),
                            SizedBox(height: 12.h),
                            BuildFieldShadow(
                              child: FirstAndLastNameField(
                                authCubit: authCubit,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            BuildFieldShadow(
                              child: EmailField(authCubit: authCubit),
                            ),
                            SizedBox(height: 16.h),
                            BuildFieldShadow(
                              child: PasswordField(authCubit: authCubit),
                            ),

                            if (authCubit.selectedUserType ==
                                UserType.worker) ...[
                              SizedBox(height: 32.h),
                              Text(
                                "Professional Details",
                                style: AppStyles.font14BlueSemiBold,
                              ),
                              SizedBox(height: 12.h),
                              BuildFieldShadow(
                                child: AppTextFormField(
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                      ? 'Phone number required'
                                      : null,
                                  controller: authCubit.phoneController,
                                  hintText: 'Phone Number',
                                  prefixIcon: Icon(
                                    Icons.phone_iphone_rounded,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.h),
                              BuildFieldShadow(
                                child: DropDownSpecialties(
                                  selectedSpecialty:
                                      authCubit.selectedSpecialty,
                                  onChanged: (value) =>
                                      authCubit.changeSpecialty(value),
                                ),
                              ),
                              SizedBox(height: 16.h),
                              BuildFieldShadow(
                                child: AddressField(authCubit: authCubit),
                              ),
                              SizedBox(height: 16.h),
                              BuildFieldShadow(
                                child: AboutFiled(authCubit: authCubit),
                              ),
                            ],

                            SizedBox(height: 40.h),
                            state is AuthLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : RegisterLoginButton(
                                    authCubit: authCubit,
                                    text: "Create Account",
                                    register: true,
                                  ),
                            SizedBox(height: 24.h),
                            const NavigateToLoginRegister(toLogin: true),
                            SizedBox(height: 40.h),
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
      height: 160.h,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60.r)),
      ),
      child: Center(
        child: SafeArea(
          child: Text(
            "Join Us",
            style: AppStyles.font18WhiteMedium.copyWith(letterSpacing: 1.2),
          ),
        ),
      ),
    );
  }
}
