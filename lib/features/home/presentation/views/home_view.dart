import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/core/di/injection.dart';
import 'package:servicenear/common/core/routes_path.dart';
import 'package:servicenear/common/entities/app_user.dart';
import 'package:servicenear/common/entities/user_type.dart';
import 'package:servicenear/common/widgets/app_styles.dart';
import 'package:servicenear/common/widgets/app_text_form_field.dart';
import 'package:servicenear/features/auth/domain/constants/worker_spicialties.dart';
import 'package:servicenear/features/home/presentation/cubit/home_cubit.dart';
import 'package:servicenear/features/home/presentation/cubit/home_state.dart';
import 'package:servicenear/features/home/presentation/widgets/category_item.dart';
import 'package:servicenear/features/home/presentation/widgets/worker_card.dart';
import 'package:servicenear/features/serviceRequest/presentation/cubit/service_request_cubit.dart';
import 'package:servicenear/features/serviceRequest/presentation/cubit/service_request_state.dart';
import 'package:servicenear/features/serviceRequest/presentation/widgets/service_request_card.dart';

class HomeView extends StatelessWidget {
  final AppUser user;
  const HomeView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final isCustomer = user.userType == UserType.customer;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= Search Bar =================
            AppTextFormField(
              hintText: isCustomer
                  ? 'Search for services or workers'
                  : 'Search for your requests or clients',
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
            SizedBox(height: 20.h),

            // ================= Customer UI =================
            if (isCustomer) ...[
              Text('Categories', style: AppStyles.font18DarkGreyMedium),
              SizedBox(height: 10.h),
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
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Workers', style: AppStyles.font18DarkGreyMedium),
                  GestureDetector(
                    onTap: () {
                      context.push(RoutePath.workers);
                    },
                    child: Text(
                      'View all',
                      style: AppStyles.font18DarkBlueSemiBold.copyWith(
                        color: AppColors.primary,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
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
                            user: worker,
                            specialist: worker.specialty ?? 'No specialty',
                          );
                        },
                      );
                    } else if (state is HomeError) {
                      return Center(child: Text(state.message));
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ],
            if (!isCustomer) ...[
              Text('Your Requests', style: AppStyles.font18DarkGreyMedium),

              SizedBox(height: 12.h),

              BlocProvider(
                create: (_) =>
                    sl<ServiceRequestCubit>()..getServiceRequests(user.id),
                child: Expanded(
                  child: BlocBuilder<ServiceRequestCubit, ServiceRequestState>(
                    builder: (context, state) {
                      if (state is ServiceRequestLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is ServiceRequestLoaded) {
                        final requests = state.requests;

                        return ListView.separated(
                          padding: EdgeInsets.only(bottom: 20.h),
                          itemCount: requests.length,
                          separatorBuilder: (_, _) => SizedBox(height: 14.h),
                          itemBuilder: (context, index) {
                            return ServiceRequestCard(
                              request: requests[index],
                              onTap: () {
                                context.push(
                                  RoutePath.requestDetails,
                                  extra: requests[index],
                                );
                              },
                            );
                          },
                        );
                      }

                      if (state is ServiceRequestError) {
                        return Center(child: Text(state.message));
                      }

                      return const SizedBox();
                    },
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
