import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicenear/common/entities/user_type.dart';
import 'package:servicenear/features/auth/domain/repositories/auth_repository.dart';
import 'package:servicenear/common/core/repositories/user_repository.dart';
import 'app_auth_state.dart';

class AuthCubit extends Cubit<AppAuthState> {
  AuthCubit(this.authRepository, this.userRepository) : super(AuthInitial());

  final AuthRepository authRepository;
  final UserRepository userRepository;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final aboutController = TextEditingController();

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
        address: addressController.text.trim(),
        about: aboutController.text.trim(),
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
      await authRepository.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final currentUser = await userRepository.getCurrentUser();
      if (currentUser == null) {
        emit(AuthError("Failed to fetch user data"));
        return;
      }

      emit(AuthLoggedIn(currentUser));
    } catch (e) {
      emit(AuthError(e.toString()));
      debugPrint(e.toString());
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await authRepository.logout();

      emailController.clear();
      passwordController.clear();

      emit(AuthInitial());
    } catch (e) {
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
