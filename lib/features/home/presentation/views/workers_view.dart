import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/widgets/app_styles.dart';
import 'package:servicenear/features/home/presentation/cubit/home_cubit.dart';
import 'package:servicenear/features/home/presentation/cubit/home_state.dart';

class WorkersView extends StatelessWidget {
  const WorkersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('All Workers'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
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

            if (workers.isEmpty) {
              return const Center(child: Text('No workers found'));
            }

            return ListView.separated(
              padding: EdgeInsets.all(20.w),
              itemCount: workers.length,
              separatorBuilder: (_, _) => SizedBox(height: 15.h),
              itemBuilder: (context, index) {
                final worker = workers[index];

                return Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30.r,
                        backgroundImage: NetworkImage(
                          'https://i.pravatar.cc/150?img=${index + 5}',
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${worker.firstName} ${worker.lastName}',
                              style: AppStyles.font18DarkGreyMedium,
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              worker.specialty ?? 'No specialty',
                              style: AppStyles.font14GrayRegular,
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: AppColors.textHint,
                      ),
                    ],
                  ),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
