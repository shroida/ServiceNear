import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/widgets/app_styles.dart';
import 'package:servicenear/common/widgets/app_text_form_field.dart';
import 'package:servicenear/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:servicenear/features/auth/presentation/widgets/drop_down_specialties.dart';
import 'package:servicenear/features/auth/presentation/widgets/models/user_type.dart';
import 'package:servicenear/features/auth/presentation/widgets/type_selector.dart';
import 'package:servicenear/features/auth/presentation/widgets/welcome_text.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
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
                  setState(() {
                    authCubit.selectedUserType = type;
                  });
                },
              ),
              SizedBox(height: 30.h),
              Form(
                key: authCubit.formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: AppTextFormField(
                            hintText: 'First Name',
                            hintStyle: AppStyles.font13GrayRegular,
                            controller: authCubit.firstNameController,
                            validator: (v) => v == null || v.isEmpty
                                ? 'Enter your last name'
                                : null,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: AppTextFormField(
                            hintText: 'Last Name',
                            hintStyle: AppStyles.font13GrayRegular,
                            controller: authCubit.lastNameController,
                            validator: (v) => v == null || v.isEmpty
                                ? 'Enter your first name'
                                : null,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),
                    AppTextFormField(
                      hintText: 'Email',
                      hintStyle: AppStyles.font13GrayRegular,
                      controller: authCubit.emailController,
                      validator: (v) => v == null || !v.contains('@')
                          ? 'Enter valid email'
                          : null,
                    ),
                    SizedBox(height: 16.h),
                    AppTextFormField(
                      hintText: 'Password',
                      hintStyle: AppStyles.font13GrayRegular,
                      controller: authCubit.passwordController,
                      isObscureText: true,
                      validator: (v) =>
                          v != null && v.length < 6 ? 'Min 6 chars' : null,
                    ),
                    SizedBox(height: 16.h),

                    // Conditional fields for Worker
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
                          setState(() {
                            authCubit.selectedSpecialty = value;
                          });
                        },
                      ),
                    ],

                    SizedBox(height: 30.h),

                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                        ),
                        onPressed: _register,
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
        ),
      ),
    );
  }

  void _register() {
    print('ok');
  }
}
