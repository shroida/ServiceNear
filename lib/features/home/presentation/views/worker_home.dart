import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:servicenear/common/core/di/injection.dart';
import 'package:servicenear/common/core/routes_path.dart';
import 'package:servicenear/common/entities/app_user.dart';
import 'package:servicenear/common/widgets/app_styles.dart';
import 'package:servicenear/features/serviceRequest/presentation/cubit/service_request_cubit.dart';
import 'package:servicenear/features/serviceRequest/presentation/cubit/service_request_state.dart';
import 'package:servicenear/features/serviceRequest/presentation/widgets/service_request_card.dart';

class WorkerHome extends StatelessWidget {
  final AppUser user;

  const WorkerHome({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Your Requests', style: AppStyles.font18DarkGreyMedium),

        SizedBox(height: 12.h),

        BlocProvider(
          create: (_) => sl<ServiceRequestCubit>()..getServiceRequests(user.id),
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
    );
  }
}
