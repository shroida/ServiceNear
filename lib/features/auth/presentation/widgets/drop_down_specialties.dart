import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/widgets/app_styles.dart';
import 'package:servicenear/features/auth/domain/constants/worker_spicialties.dart';

class DropDownSpecialties extends StatelessWidget {
  const DropDownSpecialties({
    super.key,
    required this.selectedSpecialty,
    required this.onChanged,
  });

  final String? selectedSpecialty;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedSpecialty,
      hint: Text(
        'Select Specialty',
        style: AppStyles.font13GrayRegular,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.textOnPrimary,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(
            color: AppColors.textOnPrimary,
            width: 1.3,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1.3,
          ),
        ),
      ),
      items: workerSpecialties
          .map(
            (specialty) => DropdownMenuItem(
              value: specialty,
              child: Text(
                specialty,
                style: AppStyles.font14DarkBlueMedium,
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
      validator: (value) =>
          value == null ? 'Please select your specialty' : null,
    );
  }
}
