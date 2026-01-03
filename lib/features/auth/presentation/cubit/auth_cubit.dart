import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicenear/features/auth/domain/entities/user_type.dart';
import 'package:servicenear/features/auth/domain/repositories/auth_repository.dart';

class AuthCubit extends Cubit<void> {
  AuthCubit(this.authRepository) : super(null);
  final AuthRepository authRepository;

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
    authRepository.register(email: email, password: password, firstName: firstName, lastName: lastName, userType: userType, latitude: latitude, longitude: longitude)
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
