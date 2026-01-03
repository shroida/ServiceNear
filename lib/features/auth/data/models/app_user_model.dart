import '../../domain/entities/app_user.dart';
import '../../domain/entities/user_type.dart';

class AppUserModel extends AppUser {
  const AppUserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.userType,
    required super.location,
    required super.createdAt,
  });

  factory AppUserModel.fromJson(Map<String, dynamic> json) {
    return AppUserModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      userType:
          json['user_type'] == 'worker' ? UserType.worker : UserType.customer,
      location: json['location'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'user_type': userType.name,
      'location': location,
    };
  }
}
