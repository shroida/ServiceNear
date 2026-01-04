import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/widgets/app_snack_bar.dart';
import 'package:servicenear/common/widgets/app_styles.dart';
import 'package:servicenear/common/widgets/app_text_form_field.dart';
import 'package:servicenear/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:servicenear/features/auth/presentation/cubit/auth_state.dart';
import 'package:servicenear/features/auth/presentation/widgets/drop_down_specialties.dart';
import 'package:servicenear/features/auth/domain/entities/user_type.dart';
import 'package:servicenear/features/auth/presentation/widgets/email_field.dart';
import 'package:servicenear/features/auth/presentation/widgets/first_and_last_name.dart';
import 'package:servicenear/features/auth/presentation/widgets/password_field.dart';
import 'package:servicenear/features/auth/presentation/widgets/type_selector.dart';
import 'package:servicenear/features/auth/presentation/widgets/welcome_text.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
                        FirstAndLastNameField(authCubit: authCubit),
                        SizedBox(height: 16.h),
                        EmailField(authCubit: authCubit),
                        SizedBox(height: 16.h),
                        PasswordField(authCubit: authCubit),
                        SizedBox(height: 16.h),
                        if (authCubit.selectedUserType == UserType.worker) ...[
                          AppTextFormField(
                            hintText: 'Phone Number',
                            hintStyle: AppStyles.font13GrayRegular,
                            controller: authCubit.phoneController,
                            validator: (v) =>
                                v == null || v.isEmpty ? 'Enter phone' : null,
                          ),
                          SizedBox(height: 16.h),
                          DropDownSpecialties(
                            selectedSpecialty: authCubit.selectedSpecialty,
                            onChanged: (value) {
                              authCubit.changeSpecialty(value);
                            },
                          ),
                        ],
                        SizedBox(height: 30.h),
                        state is AuthLoading
                            ? const Center(child: CircularProgressIndicator())
                            : SizedBox(
                                width: double.infinity,
                                height: 50.h,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.r),
                                    ),
                                  ),
                                  onPressed: () => authCubit.register(),
                                  child: Text(
                                    'Register',
                                    style: AppStyles.font16WhiteSemiBold,
                                  ),
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
      ),
    );
  }
}
