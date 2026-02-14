import 'package:flutter/material.dart';
import 'package:servicenear/common/widgets/app_styles.dart';
import 'package:servicenear/common/widgets/app_text_form_field.dart';
import 'package:servicenear/features/auth/presentation/cubit/auth_cubit.dart';

class AddressField extends StatelessWidget {
  const AddressField({super.key, required this.authCubit});

  final AuthCubit authCubit;

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      controller: authCubit.addressController,
      hintText: 'Address',
      hintStyle: AppStyles.font13GrayRegular,

      validator: (value) =>
          value == null || value.isEmpty ? 'Address required' : null,
      prefixIcon: const Icon(Icons.location_on),
    );
  }
}
