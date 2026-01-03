import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicenear/features/auth/domain/entities/user_type.dart';

class AuthCubit extends Cubit<void> {
  AuthCubit() : super(null);
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  UserType selectedUserType = UserType.customer;
  String? selectedSpecialty;

  void changeUserType(UserType type) {
    selectedUserType = type;
    emit(null);
  }

  void changeSpecialty(String? specialty) {
    selectedSpecialty = specialty;
    emit(null);
  }

  void register(GlobalKey<FormState> formKey) {
    debugPrint('Selected User : $selectedUserType');
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    return super.close();
  }
}
