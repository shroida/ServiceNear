import 'package:servicenear/common/entities/app_user.dart';

class AuthInitial extends AppAuthState {}

abstract class AppAuthState {
  String get currentUserId => '';
}

class AuthAuthenticated extends AppAuthState {
  final AppUser user;
  AuthAuthenticated(this.user);

  @override
  String get currentUserId => user.id;
}

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
