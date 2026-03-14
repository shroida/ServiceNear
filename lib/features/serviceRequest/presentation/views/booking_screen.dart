import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/widgets/app_styles.dart';
import 'package:servicenear/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:servicenear/features/chat/presentation/views/chat_list_view.dart';
import 'package:servicenear/features/serviceRequest/domain/entities/service_request.dart';
import 'package:servicenear/features/serviceRequest/presentation/cubit/service_request_cubit.dart';
import 'package:servicenear/features/serviceRequest/presentation/cubit/service_request_state.dart';
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
                      return _BookingCard(request: request);
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

class _BookingCard extends StatelessWidget {
  final ServiceRequest request;

  const _BookingCard({required this.request});

  @override
  Widget build(BuildContext context) {
    final title = request.title;
    final status = request.status;
    final location = request.location ?? "Remote";

    final date = request.createdAt;
    final dateStr = "${date.year}-${date.month}-${date.day}";

    bool isActionable = status == 'pending' || status == 'confirmed';

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25.r,
                backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                child: Icon(Icons.build_circle, color: AppColors.primary),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppStyles.font15DarkBlueMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "Status: ${status.toUpperCase()}",
                      style: AppStyles.font12GrayMedium,
                    ),
                  ],
                ),
              ),
              _buildStatusBadge(status),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: const Divider(height: 1),
          ),
          Row(
            children: [
              Icon(
                Icons.calendar_month_outlined,
                size: 16.sp,
                color: AppColors.primary,
              ),
              SizedBox(width: 6.w),
              Text(dateStr, style: AppStyles.font13BlueSemiBold),
              const Spacer(),
              Icon(
                Icons.location_on_outlined,
                size: 16.sp,
                color: AppColors.primary,
              ),
              SizedBox(width: 6.w),
              Flexible(
                child: Text(
                  location,
                  style: AppStyles.font13BlueSemiBold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          if (isActionable) ...[
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final chatCubit = context.read<ChatCubit>();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: chatCubit,
                            child: ChatListView(
                              currentUserId:
                                  Supabase.instance.client.auth.currentUser!.id,
                              cubit: chatCubit,
                            ),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: const Text(
                      "Contact Worker",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;

    switch (status.toLowerCase()) {
      case 'confirmed':
      case 'accepted':
        color = Colors.green;
        break;
      case 'pending':
        color = Colors.orange;
        break;
      case 'completed':
        color = Colors.blue;
        break;
      case 'cancelled':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
