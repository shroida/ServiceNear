import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicenear/features/auth/domain/entities/app_user.dart';
import 'package:servicenear/features/auth/domain/entities/user_type.dart';
import 'package:servicenear/features/auth/domain/repositories/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthInitial());
  AppUser? currentUser;

  final AuthRepository authRepository;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  UserType selectedUserType = UserType.customer;
  String? selectedSpecialty;

  double latitude = 0.0;
  double longitude = 0.0;

  void changeUserType(UserType type) {
    selectedUserType = type;
    emit(AuthInitial());
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(AuthInitial());
  }

  void changeSpecialty(String? specialty) {
    selectedSpecialty = specialty;
    emit(AuthInitial());
  }

  Future<void> register() async {
    if (!formKey.currentState!.validate()) return;

    emit(AuthLoading());

    try {
      await authRepository.register(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        userType: selectedUserType,
        latitude: latitude,
        longitude: longitude,
        specialty: selectedSpecialty,
        phone: phoneController.text.trim(),
      );

      emit(AuthSuccess('Registered successfully'));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      emit(AuthError('Please fill all required fields'));
      return;
    }

    emit(AuthLoading());

    try {
      final user = await authRepository.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      currentUser = user;
      emit(AuthSuccess('Logged in successfully'));
    } on Exception catch (e) {
      String message = 'Something went wrong. Please try again.';

      if (e.toString().contains('Invalid login credentials')) {
        message = 'Email or password is incorrect';
      }

      emit(AuthError(message));
    }
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
