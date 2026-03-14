import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/widgets/app_styles.dart';
import 'package:servicenear/features/serviceRequest/domain/entities/service_request.dart';
import 'package:servicenear/features/serviceRequest/presentation/cubit/service_request_cubit.dart';
import 'package:servicenear/features/serviceRequest/presentation/cubit/service_request_state.dart';

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

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
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
          // SAFE FILTERING: Handle every possible null scenario
          final filteredRequests = state.requests.where((req) {
            // Use .toString() to ensure we never call .toLowerCase() on a null
            final String status = (req.status ?? 'pending')
                .toString()
                .toLowerCase()
                .trim();

            if (isActive) {
              // Your logs showed 'accepted' status, so we include it here
              return status == 'pending' ||
                  status == 'confirmed' ||
                  status == 'accepted';
            } else {
              return status == 'completed' || status == 'cancelled';
            }
          }).toList();

          if (filteredRequests.isEmpty) {
            return Center(
              child: Text(
                isActive ? "No upcoming bookings" : "No past history",
                style: AppStyles.font14GrayRegular,
              ),
            );
          }

          return ListView.builder(
            key: PageStorageKey(isActive ? 'upcoming' : 'history'),
            padding: EdgeInsets.symmetric(vertical: 10.h),
            itemCount: filteredRequests.length,
            itemBuilder: (context, index) {
              // Range check to prevent index errors
              if (index >= filteredRequests.length)
                return const SizedBox.shrink();
              return _BookingCard(request: filteredRequests[index]);
            },
          );
        }

        if (state is ServiceRequestError) {
          return Center(child: Text(state.message));
        }

        return const Center(child: Text("No bookings found"));
      },
    );
  }
}

class _BookingCard extends StatelessWidget {
  final ServiceRequest request;
  const _BookingCard({required this.request});

  @override
  Widget build(BuildContext context) {
    // FORCE SAFETY: Map entity fields to local safe variables
    // This prevents the "Null is not subtype of String" crash if the entity is strict
    final String title = (request.title ?? "Untitled Service").toString();
    final String status = (request.status ?? "pending")
        .toString()
        .toLowerCase();
    final String location = (request.location ?? "No location provided")
        .toString();

    // Safely format Date
    String dateStr = "Unknown Date";
    try {
      // Use a local variable for the date to ensure null safety
      final date = request.createdAt;
      if (date != null) {
        dateStr =
            "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      }
    } catch (e) {
      dateStr = "Date Error";
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
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
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: Icon(Icons.build_circle, color: AppColors.primary),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppStyles.font14DarkBlueMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
          const Divider(height: 32),
          Row(
            children: [
              Icon(Icons.calendar_month, size: 16.sp, color: AppColors.primary),
              SizedBox(width: 6.w),
              Text(dateStr, style: AppStyles.font13BlueSemiBold),
              const Spacer(),
              Icon(Icons.location_on, size: 16.sp, color: AppColors.primary),
              SizedBox(width: 6.w),
              Flexible(
                child: Text(
                  location,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.font13BlueSemiBold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    switch (status) {
      case 'pending':
        color = Colors.orange;
        break;
      case 'accepted':
      case 'confirmed':
        color = Colors.green;
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
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
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
