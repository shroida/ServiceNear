import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicenear/features/serviceRequest/domain/entities/service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/widgets/app_styles.dart';
import 'package:servicenear/common/widgets/app_text_form_field.dart';
import 'package:servicenear/features/serviceRequest/domain/entities/service_request.dart';
import 'package:servicenear/features/serviceRequest/presentation/cubit/service_request_cubit.dart';
import 'package:servicenear/features/serviceRequest/presentation/cubit/service_request_state.dart';

class AddRequestScreen extends StatefulWidget {
  final String? workerId;
  final Service? service;

  const AddRequestScreen({super.key, this.service, this.workerId});

  @override
  State<AddRequestScreen> createState() => _AddRequestScreenState();
}

class _AddRequestScreenState extends State<AddRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _submitRequest() async {
    if (!_formKey.currentState!.validate()) return;

    final service = widget.service;
    if (service == null) return;

    final request = ServiceRequest(
      customerId: Supabase.instance.client.auth.currentUser!.id,
      workerId: widget.workerId ?? '',
      title: _titleController.text,
      serviceId: service.id ?? '',
      description: _descriptionController.text,
      status: 'pending',
      location: null,
      createdAt: DateTime.now(),
    );

    context.read<ServiceRequestCubit>().createRequest(request);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: BackButton(color: AppColors.primary),
        title: Text("Create Request", style: AppStyles.font18DarkBlueBold),
      ),
      body: BlocConsumer<ServiceRequestCubit, ServiceRequestState>(
        listener: (context, state) {
          if (state is ServiceRequestLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Request sent successfully!")),
            );
            Navigator.pop(context);
          } else if (state is ServiceRequestError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.redAccent,
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildServiceHighlight(),

                  SizedBox(height: 24.h),
                  Text("Request Details", style: AppStyles.font16DarkBlueBold),
                  SizedBox(height: 16.h),

                  // ... inside your Column in AddRequestScreen
                  _inputLabel("What do you need?"),
                  _buildFieldShadow(
                    child: AppTextFormField(
                      controller: _titleController,
                      hintText: "e.g. Fix leaking kitchen sink",
                      // FIXED: Explicitly setting the hint style to be darker if you want it black
                      hintStyle: AppStyles.font14GrayRegular.copyWith(
                        color: Colors.black54,
                      ),
                      prefixIcon: Icon(
                        Icons.title_rounded,
                        color: AppColors.primary,
                        size: 20.sp,
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? "Title is required"
                          : null,
                    ),
                  ),

                  SizedBox(height: 16.h),

                  _inputLabel("Tell us the details"),
                  _buildFieldShadow(
                    child: AppTextFormField(
                      controller: _descriptionController,
                      hintText: "Describe the issue...",
                      hintStyle: AppStyles.font14GrayRegular.copyWith(
                        color: Colors.black54,
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? "Please add a description"
                          : null,
                    ),
                  ),

                  SizedBox(height: 16.h),

                  _inputLabel("Where is the service needed?"),
                  _buildFieldShadow(
                    child: AppTextFormField(
                      controller: _addressController,
                      hintText: "Your home or office address",
                      hintStyle: AppStyles.font14GrayRegular.copyWith(
                        color: Colors.black54,
                      ),
                      prefixIcon: Icon(
                        Icons.location_on_rounded,
                        color: AppColors.primary,
                        size: 20.sp,
                      ),

                      validator: (value) => value == null || value.isEmpty
                          ? "Address is required"
                          : null,
                    ),
                  ),

                  SizedBox(height: 40.h),

                  _buildActionButton(state is ServiceRequestLoading),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildServiceHighlight() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: const Icon(
              Icons.settings_suggest_rounded,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 14.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.service?.title ?? "Service",
                style: AppStyles.font16DarkBlueBold,
              ),
              Text(
                widget.service?.specialty ?? "Booking request",
                style: AppStyles.font14GrayRegular,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _inputLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w, bottom: 8.h),
      child: Text(text, style: AppStyles.font14DarkBlueMedium),
    );
  }

  Widget _buildActionButton(bool isLoading) {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : _submitRequest,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? SizedBox(
                height: 24.h,
                width: 24.h,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text("Confirm and Submit", style: AppStyles.font16WhiteSemiBold),
      ),
    );
  }

  Widget _buildFieldShadow({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03), // Ultra soft shadow
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
