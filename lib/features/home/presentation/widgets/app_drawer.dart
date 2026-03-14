import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/core/routes_path.dart';
import 'package:servicenear/common/entities/app_user.dart';
import 'package:servicenear/common/widgets/font_weight_helper.dart';
import 'package:servicenear/common/core/repositories/user_repository.dart';
import 'package:servicenear/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final userRepository = UserRepository(Supabase.instance.client);

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            /// ================== HEADER ==================
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryLight],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24.r),
                  bottomRight: Radius.circular(24.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.r,
                    offset: Offset(0, 4.h),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28.r,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.home_repair_service,
                      size: 28.sp,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'ServiceNear',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeightHelper.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            _buildDrawerItem(
              context,
              icon: Icons.person_outline,
              title: 'Profile',
              onTap: () async {
                Navigator.pop(context);

                final AppUser? currentUser = await userRepository
                    .getCurrentUser();

                if (currentUser != null && context.mounted) {
                  context.push(RoutePath.profile, extra: {'user': currentUser});
                }
              },
            ),
            _buildDrawerItem(
              context,
              icon: Icons.settings_outlined,
              title: 'Settings',
              onTap: () {
                Navigator.pop(context);
                // context.go(RoutePath.settings);
              },
            ),

            const Spacer(),

            const Divider(),

            _buildDrawerItem(
              context,
              icon: Icons.logout,
              title: 'Logout',
              color: Colors.red,
              onTap: () async {
                Navigator.pop(context);
                try {
                  await context.read<AuthCubit>().logout();
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Logout failed: $e")));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color ?? AppColors.primary, size: 24.sp),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeightHelper.semiBold,
          color: color ?? AppColors.textPrimary,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
      horizontalTitleGap: 8.w,
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      hoverColor: AppColors.primary.withValues(alpha: .1),
      splashColor: AppColors.primary.withValues(alpha: .2),
    );
  }
}
