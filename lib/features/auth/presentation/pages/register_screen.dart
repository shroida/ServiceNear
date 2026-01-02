import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/widgets/app_styles.dart';
import 'package:servicenear/common/widgets/app_text_form_field.dart';
import 'package:servicenear/features/auth/presentation/widgets/models/user_type.dart';
import 'package:servicenear/features/auth/presentation/widgets/type_selector.dart';
import 'package:servicenear/features/auth/presentation/widgets/welcome_text.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController specialtyController = TextEditingController();
  UserType selectedUserType = UserType.customer;

  @override
  Widget build(BuildContext context) {
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
                selectedType: selectedUserType,
                onTypeChanged: (type) {
                  setState(() {
                    selectedUserType = type;
                  });
                },
              ),

              SizedBox(height: 30.h),

              // Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    AppTextFormField(
                      hintText: 'Full Name',
                      hintStyle: AppStyles.font13GrayRegular,
                      controller: nameController,
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Enter your name' : null,
                    ),
                    SizedBox(height: 16.h),
                    AppTextFormField(
                      hintText: 'Email',
                      hintStyle: AppStyles.font13GrayRegular,
                      controller: emailController,
                      validator: (v) => v == null || !v.contains('@')
                          ? 'Enter valid email'
                          : null,
                    ),
                    SizedBox(height: 16.h),
                    AppTextFormField(
                      hintText: 'Password',
                      hintStyle: AppStyles.font13GrayRegular,
                      controller: passwordController,
                      isObscureText: true,
                      validator: (v) =>
                          v != null && v.length < 6 ? 'Min 6 chars' : null,
                    ),
                    SizedBox(height: 16.h),

                    // Conditional fields for Worker
                    if (selectedUserType == UserType.worker) ...[
                      AppTextFormField(
                        hintText: 'Phone Number',
                        hintStyle: AppStyles.font13GrayRegular,
                        controller: phoneController,
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Enter phone' : null,
                      ),
                      SizedBox(height: 16.h),
                      AppTextFormField(
                        hintText: 'Specialty',
                        hintStyle: AppStyles.font13GrayRegular,
                        controller: specialtyController,
                        validator: (v) => v == null || v.isEmpty
                            ? 'Enter your specialty'
                            : null,
                      ),
                    ],

                    SizedBox(height: 30.h),

                    // Register Button
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
    if (_formKey.currentState!.validate()) {
      // TODO: Call Supabase Auth & save user in users table
      if (selectedUserType == UserType.customer) {
        print('Registering Customer: ${nameController.text}');
      } else {
        print('Registering Worker: ${nameController.text}');
      }
    }
  }
}
