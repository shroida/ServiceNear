import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenear/common/core/di/injection.dart';
import 'package:servicenear/common/entities/worker.dart';
import 'package:servicenear/common/widgets/custom_app_bar.dart';
import 'package:servicenear/features/WorkerInfo/domain/entities/rating_entity.dart';
import 'package:servicenear/features/WorkerInfo/presentation/cubit/rating_cubit.dart';
import 'package:servicenear/features/WorkerInfo/presentation/widgets/about_widget.dart';
import 'package:servicenear/features/WorkerInfo/presentation/widgets/customer_rating_widget.dart';
import 'package:servicenear/features/WorkerInfo/presentation/widgets/info_card.dart';
import 'package:servicenear/features/WorkerInfo/presentation/widgets/rating_section.dart';
import 'package:servicenear/features/WorkerInfo/presentation/widgets/worker_info_header.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WorkerInfoScreen extends StatelessWidget {
  final Worker worker;
  const WorkerInfoScreen({super.key, required this.worker});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "${worker.firstName} ${worker.lastName}",
        subtitle: worker.specialty ?? "Worker",
      ),
      backgroundColor: AppColors.background,
      body: BlocProvider(
        create: (_) => RatingCubit(sl()),

        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                WorkerInfoHeader(worker: worker),
                SizedBox(height: 20.h),
                AboutSection(
                  about:
                      worker.about ??
                      "No description available for this worker.",
                ),

                SizedBox(height: 5.h),
                InfoCard(worker: worker),
                SizedBox(height: 5.h),
                RatingSection(rating: 5.5, reviewsCount: 15),
                SizedBox(height: 5.h),
                CustomerRatingWidget(
                  onSubmit: (rating, review) {
                    final user = Supabase.instance.client.auth.currentUser;

                    if (user == null) return;

                    context.read<RatingCubit>().submitRating(
                      RatingEntity(
                        createdAt: DateTime.now(),
                        ratingrId: "",
                        workerId: worker.id,
                        customerId: user.id,
                        rating: rating,
                        review: review,
                      ),
                    );
                  },
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
