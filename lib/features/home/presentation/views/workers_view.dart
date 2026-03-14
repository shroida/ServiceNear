import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/core/images.dart';
import 'package:servicenear/common/core/routes_path.dart';
import 'package:servicenear/common/widgets/app_styles.dart';
import 'package:servicenear/features/home/presentation/cubit/home_cubit.dart';
import 'package:servicenear/features/home/presentation/cubit/home_state.dart';

class WorkersView extends StatelessWidget {
  const WorkersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HomeError) {
            return Center(
              child: Text(state.message, style: AppStyles.font14GrayRegular),
            );
          }

          if (state is HomeLoaded) {
            final workers = state.workers;

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  elevation: 0,
                  backgroundColor: AppColors.background,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    onPressed: () => context.pop(),
                  ),
                  title: Text(
                    'Available Workers',
                    style: AppStyles.font18DarkGreyMedium,
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  sliver: SliverList.separated(
                    itemCount: workers.length,
                    separatorBuilder: (_, _) => SizedBox(height: 14.h),
                    itemBuilder: (context, index) {
                      final worker = workers[index];

                      return Material(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(18.r),
                        elevation: 2,
                        shadowColor: Colors.black.withValues(alpha: .05),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(18.r),
                          onTap: () {
                            context.pushNamed(
                              RoutePath.workerInfo,
                              extra: {
                                'user': worker,
                                'specialty': worker.specialty ?? '',
                              },
                            );
                          },

                          child: Padding(
                            padding: EdgeInsets.all(16.w),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 32.r,
                                  backgroundColor: Colors.grey.shade100,
                                  child: ClipOval(
                                    child: Image.asset(
                                      getWorkerImage(worker.specialty),
                                      width: 60.w,
                                      height: 60.h,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16.w),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${worker.firstName} ${worker.lastName}',
                                        style: AppStyles.font18DarkGreyMedium,
                                      ),
                                      SizedBox(height: 6.h),

                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.w,
                                          vertical: 4.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary.withValues(
                                            alpha: .1,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            20.r,
                                          ),
                                        ),
                                        child: Text(
                                          worker.specialty ?? 'General',
                                          style: AppStyles.font13BlueSemiBold,
                                        ),
                                      ),

                                      SizedBox(height: 8.h),

                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            size: 16,
                                            color: Colors.amber,
                                          ),
                                          SizedBox(width: 4.w),
                                          Text(
                                            '4.8',
                                            style: AppStyles.font14GrayRegular,
                                          ),
                                          SizedBox(width: 12.w),
                                          const Icon(
                                            Icons.location_on,
                                            size: 16,
                                            color: AppColors.textHint,
                                          ),
                                          SizedBox(width: 4.w),
                                          Text(
                                            '2.3 km',
                                            style: AppStyles.font14GrayRegular,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                const Icon(
                                  Icons.chevron_right,
                                  color: AppColors.textHint,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
