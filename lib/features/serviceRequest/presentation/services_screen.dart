import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:servicenear/common/core/routes_path.dart';
import 'package:servicenear/common/widgets/custom_app_bar.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/widgets/app_styles.dart';
import 'package:servicenear/features/serviceRequest/presentation/cubit/service_request_cubit.dart';
import 'package:servicenear/features/serviceRequest/presentation/cubit/service_request_state.dart';
import 'package:servicenear/features/serviceRequest/presentation/widgets/service_card.dart';

class ServicesScreen extends StatelessWidget {
  final String workerId;
  const ServicesScreen({super.key, required this.workerId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(title: 'Available Services', subtitle: ''),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: BlocBuilder<ServiceRequestCubit, ServiceRequestState>(
          builder: (context, state) {
            if (state is ServiceLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ServiceLoaded) {
              final services = state.services;

              if (services.isEmpty) {
                return Center(
                  child: Text(
                    "No services available",
                    style: AppStyles.font16WhiteSemiBold.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                );
              }

              return ListView.separated(
                itemCount: services.length,
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  final service = services[index];
                  return ServiceCard(
                    service: service,
                    onTap: () {
                      context.push(
                        RoutePath.addRequest,
                        extra: {
                          'service': service,
                          'workerId': workerId, // pass it as a key in a map
                        },
                      );
                    },
                  );
                },
              );
            } else if (state is ServiceError) {
              return Center(
                child: Text(
                  state.message,
                  style: AppStyles.font16WhiteSemiBold.copyWith(
                    color: AppColors.error,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
