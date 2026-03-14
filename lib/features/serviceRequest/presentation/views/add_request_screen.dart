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
    final service = widget.service;
    if (service == null) return;

    final request = ServiceRequest(
      customerId: Supabase.instance.client.auth.currentUser!.id,
      workerId: widget.workerId ?? '',
      title: service.title,
      serviceId: service.id ?? '',
      description: _descriptionController.text,
      status: 'pending',
      location: null,
      createdAt: DateTime.now(),
    );

    final cubit = context.read<ServiceRequestCubit>();
    await cubit.createRequest(request);
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
                  "Service: ${widget.service!.id}",
                  style: AppStyles.font16WhiteSemiBold.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  "Service: ${widget.workerId}",
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
