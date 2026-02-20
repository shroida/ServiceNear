import 'package:servicenear/common/entities/app_user.dart';

abstract class AppAuthState {}

class AuthInitial extends AppAuthState {}

class AuthLoading extends AppAuthState {}

class AuthSuccess extends AppAuthState {
  final String message;
  final AppUser? user;
  AuthSuccess(this.message, {this.user});
}

class AuthError extends AppAuthState {
  final String message;
  AuthError(this.message);
}

class AuthLoggedIn extends AppAuthState {
  final AppUser user;
  AuthLoggedIn(this.user);
}
