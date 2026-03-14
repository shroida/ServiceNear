import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/widgets/app_styles.dart';
import 'package:servicenear/features/serviceRequest/presentation/cubit/service_request_cubit.dart';
import 'package:servicenear/features/serviceRequest/presentation/cubit/service_request_state.dart';
import 'package:servicenear/features/serviceRequest/presentation/widgets/booking_card.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<void> _refresh() async {
    final userId = Supabase.instance.client.auth.currentUser?.id ?? '';
    if (userId.isNotEmpty) {
      await context.read<ServiceRequestCubit>().fetchBookedServices(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("My Bookings", style: AppStyles.font20DarkBlueBold),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: Colors.grey,
          indicatorColor: AppColors.primary,
          indicatorWeight: 3,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: AppStyles.font14BlueSemiBold,
          tabs: const [
            Tab(text: "Upcoming"),
            Tab(text: "History"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBookingsList(isActive: true),
          _buildBookingsList(isActive: false),
        ],
      ),
    );
  }

  Widget _buildBookingsList({required bool isActive}) {
    return BlocBuilder<ServiceRequestCubit, ServiceRequestState>(
      builder: (context, state) {
        if (state is ServiceRequestLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ServiceRequestLoaded) {
          final filteredRequests = state.requests.where((req) {
            final status = (req.status).toLowerCase().trim();
            if (isActive) {
              return status == 'pending' ||
                  status == 'confirmed' ||
                  status == 'accepted';
            } else {
              return status == 'completed' || status == 'cancelled';
            }
          }).toList();

          return RefreshIndicator(
            onRefresh: _refresh,
            child: filteredRequests.isEmpty
                ? ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      SizedBox(height: 200.h),
                      Center(
                        child: Text(
                          isActive ? "No upcoming bookings" : "No past history",
                          style: AppStyles.font14GrayRegular,
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    itemCount: filteredRequests.length,
                    itemBuilder: (context, index) {
                      final request = filteredRequests[index];
                      return BookingCard(request: request);
                    },
                  ),
          );
        }

        return const Center(
          child: Text("Start booking services to see them here!"),
        );
      },
    );
  }
}
