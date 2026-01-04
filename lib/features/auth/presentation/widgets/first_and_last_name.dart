import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenear/common/widgets/app_styles.dart';
import 'package:servicenear/common/widgets/app_text_form_field.dart';
import 'package:servicenear/features/auth/presentation/cubit/auth_cubit.dart';

class FirstAndLastNameField extends StatelessWidget {
  const FirstAndLastNameField({
    super.key,
    required this.authCubit,
  });

  final AuthCubit authCubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppTextFormField(
            hintText: 'First Name',
            hintStyle: AppStyles.font13GrayRegular,
            controller: authCubit.firstNameController,
            validator: (v) =>
                v == null || v.isEmpty ? 'Enter your first name' : null,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: AppTextFormField(
            hintText: 'Last Name',
            hintStyle: AppStyles.font13GrayRegular,
            controller: authCubit.lastNameController,
            validator: (v) =>
                v == null || v.isEmpty ? 'Enter your last name' : null,
          ),
        ),
      ],
    );
  }
}
