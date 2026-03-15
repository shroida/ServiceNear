import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:servicenear/common/core/app_colors.dart';
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

class HomeView extends StatefulWidget {
  final AppUser user;
  const HomeView({super.key, required this.user});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String selectedCategory = '';

  @override
  Widget build(BuildContext context) {
    final isCustomer = widget.user.userType == UserType.customer;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => context.read<HomeCubit>().fetchWorkers(),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      SizedBox(height: 20.h),
                      _buildSearchBar(isCustomer),
                    ],
                  ),
                ),
              ),

              // ================= Categories =================
              if (isCustomer) ...[
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Text(
                          'Categories',
                          style: AppStyles.font18DarkBlueBold,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      SizedBox(
                        height: 120.h,
                        child: ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          scrollDirection: Axis.horizontal,
                          itemCount: workerCategories.length,
                          separatorBuilder: (_, _) => SizedBox(width: 15.w),
                          itemBuilder: (context, index) {
                            final category = workerCategories[index];
                            final isSelected =
                                selectedCategory == category.title;
                            return CategoryCard(
                              title: category.title,
                              icon: category.icon,
                              isSelected: isSelected,
                              onTap: () => setState(
                                () => selectedCategory = isSelected
                                    ? ''
                                    : category.title,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // ================= Workers Section =================
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 12.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Top Workers',
                          style: AppStyles.font18DarkBlueBold,
                        ),
                        TextButton(
                          onPressed: () => context.push(RoutePath.workers),
                          child: Text(
                            'View all',
                            style: AppStyles.font14BlueSemiBold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 280.h,
                    child: BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        if (state is HomeLoading) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        }
                        if (state is HomeLoaded) {
                          final workers = selectedCategory.isEmpty
                              ? state.workers
                              : state.workers
                                    .where(
                                      (w) =>
                                          w.specialty?.toLowerCase() ==
                                          selectedCategory.toLowerCase(),
                                    )
                                    .toList();

                          if (workers.isEmpty) {
                            return _buildEmptyState();
                          }

                          return ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            scrollDirection: Axis.horizontal,
                            itemCount: workers.length,
                            separatorBuilder: (_, _) => SizedBox(width: 16.w),
                            itemBuilder: (context, index) => WorkerCard(
                              user: workers[index],
                              specialist: workers[index].specialty ?? 'General',
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 50.h)),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello, ${widget.user.firstName} 👋",
              style: AppStyles.font24BlueBold,
            ),
            Text("Find your service today", style: AppStyles.font14GrayRegular),
          ],
        ),
        const Spacer(),
        CircleAvatar(
          radius: 25.r,
          backgroundColor: AppColors.primary.withValues(alpha: 0.1),
          child: Icon(
            Icons.notifications_none_rounded,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(bool isCustomer) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: AppTextFormField(
        hintText: isCustomer ? 'Search for services...' : 'Search requests...',
        validator: (_) => null,
        hintStyle: AppStyles.font14GrayRegular,
        prefixIcon: const Icon(Icons.search_rounded, color: AppColors.primary),
        backgroundColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 16.h),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded, size: 40.sp, color: Colors.grey),
          Text(
            "No workers in this category",
            style: AppStyles.font14GrayRegular,
          ),
        ],
      ),
    );
  }
}
