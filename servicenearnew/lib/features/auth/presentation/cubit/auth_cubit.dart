import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicenearnew/features/auth/domain/entities/user_type.dart';
import 'package:servicenearnew/features/auth/domain/repositories/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthInitial());

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
    if (!formKey.currentState!.validate()) return;

    emit(AuthLoading());

    try {
      // Await the login call
      await authRepository.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // If login succeeds, emit success
      emit(AuthSuccess('Logged in successfully'));
    } on Exception catch (e) {
      // Catch any error from Supabase or repository
      emit(AuthError(e.toString()));
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
