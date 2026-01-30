import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/entities/app_user.dart';
import 'package:servicenear/common/widgets/app_styles.dart';
import 'package:servicenear/common/widgets/app_text_form_field.dart';
import 'package:servicenear/features/auth/domain/constants/worker_spicialties.dart';
import 'package:servicenear/features/home/presentation/cubit/home_cubit.dart';
import 'package:servicenear/features/home/presentation/cubit/home_state.dart';
import 'package:servicenear/features/home/presentation/widgets/category_item.dart';
import 'package:servicenear/features/home/presentation/widgets/worker_card.dart';

class HomeView extends StatelessWidget {
  final AppUser user;
  const HomeView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextFormField(
              hintText: 'Search for services or workers',
              validator: (_) => null,
              hintStyle: AppStyles.font14GrayRegular,
              prefixIcon: const Icon(Icons.search, color: AppColors.textHint),
              backgroundColor: AppColors.divider,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 20.h,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide.none,
              ),
            ),
            SizedBox(height: 10),
            Text('Categories', style: AppStyles.font18DarkMedium),
            SizedBox(height: 10),
            SizedBox(
              height: 100.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: workerCategories.length,
                separatorBuilder: (_, _) => SizedBox(width: 20.w),
                itemBuilder: (context, index) {
                  final category = workerCategories[index];

                  return CategoryCard(
                    title: category.title,
                    icon: category.icon,
                  );
                },
              ),
            ),

            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Workers', style: AppStyles.font18DarkMedium),
                Text(
                  'View all',
                  style: AppStyles.font18DarkBlueSemiBold.copyWith(
                    color: AppColors.primary,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            SizedBox(
              height: 300.h,
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is HomeLoaded) {
                    final workers = state.workers;
                    return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: workers.length,
                      separatorBuilder: (_, _) => SizedBox(width: 20.w),
                      itemBuilder: (context, index) {
                        final worker = workers[index];
                        return WorkerCard(
                          imageUrl:
                              'https://i.pravatar.cc/150?img=${index + 1}',
                          name: '${worker.firstName} ${worker.lastName}',
                          specialist: worker.specialty ?? 'No specialty',
                        );
                      },
                    );
                  } else if (state is HomeError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const Text('there');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
