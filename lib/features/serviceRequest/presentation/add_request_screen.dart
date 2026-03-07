import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:servicenear/common/core/app_colors.dart';
import 'package:servicenear/common/widgets/app_styles.dart';
import 'package:servicenear/common/widgets/app_text_form_field.dart';
import 'package:servicenear/features/serviceRequest/domain/entities/service_request.dart';
import 'package:servicenear/features/serviceRequest/presentation/cubit/service_request_cubit.dart';
import 'package:servicenear/features/serviceRequest/presentation/cubit/service_request_state.dart';

class AddRequestScreen extends StatefulWidget {
  final String? workerId;
  final String? phone;

  const AddRequestScreen({super.key, this.workerId, this.phone});

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
    if (_formKey.currentState?.validate() != true || widget.workerId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    final currentUserId = Supabase.instance.client.auth.currentUser?.id;
    if (currentUserId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("User not logged in")));
      return;
    }

    final request = ServiceRequest(
      location: _addressController.text.trim(),
      price: 0.0,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      status: 'pending',
      workerId: widget.workerId!,
      customerId: currentUserId, // assign current user
      createdAt: DateTime.now(),
    );

    context.read<ServiceRequestCubit>().createRequest(request);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text("Add Service Request"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Worker Phone: ${widget.phone ?? 'N/A'}",
                  style: AppStyles.font16WhiteSemiBold.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 20.h),
                AppTextFormField(
                  controller: _titleController,
                  hintText: "Title",
                  validator: (value) => value == null || value.isEmpty
                      ? "Please enter a title"
                      : null,
                ),
                SizedBox(height: 12.h),
                AppTextFormField(
                  controller: _descriptionController,
                  hintText: "Description",
                  validator: (value) => value == null || value.isEmpty
                      ? "Please enter a description"
                      : null,
                ),
                SizedBox(height: 12.h),
                AppTextFormField(
                  controller: _addressController,
                  hintText: "Address",
                  validator: (value) => value == null || value.isEmpty
                      ? "Please enter an address"
                      : null,
                ),
                SizedBox(height: 24.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitRequest,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      "Submit Request",
                      style: AppStyles.font16WhiteSemiBold,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                BlocConsumer<ServiceRequestCubit, ServiceRequestState>(
                  listener: (context, state) {
                    if (state is ServiceRequestLoaded) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Request submitted successfully"),
                        ),
                      );
                      Navigator.pop(context);
                    } else if (state is ServiceRequestError) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  builder: (context, state) {
                    if (state is ServiceRequestLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
