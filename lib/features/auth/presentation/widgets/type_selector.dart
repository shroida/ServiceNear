import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/widgets/app_styles.dart';
import 'package:servicenear/features/auth/presentation/widgets/models/user_type.dart';


class TypeSelector extends StatelessWidget {
  final UserType selectedType;
  final Function(UserType) onTypeChanged;

  const TypeSelector({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _userTypeButton(UserType.customer, 'Customer'),
        SizedBox(width: 20.w),
        _userTypeButton(UserType.worker, 'Worker'),
      ],
    );
  }

  Widget _userTypeButton(UserType type, String text) {
    final bool selected = selectedType == type;
    return GestureDetector(
      onTap: () => onTypeChanged(type),
      child: Container(
        width: 140.w,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.background,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.textHint,
            width: 1.3,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: selected
              ? AppStyles.font16WhiteSemiBold
              : AppStyles.font16WhiteSemiBold
                  .copyWith(color: AppColors.textSecondary),
        ),
      ),
    );
  }
}
