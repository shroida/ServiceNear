import 'package:servicenear/common/entities/user_location.dart';
import 'package:servicenear/features/auth/domain/entities/app_user_auth.dart';

import '../../../../common/entities/user_type.dart';

class AppUserAuthRemoteModel extends AppUserAuth {
  final String? specialty;
  final String? address;
  final String? about;
  final String? phoneNumber;
  AppUserAuthRemoteModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.createdAt,
    required super.location,
    required super.userType,
    this.address,
    this.phoneNumber,
    this.specialty,
    this.about,
  });
  factory AppUserAuthRemoteModel.fromJson(Map<String, dynamic> json) {
    return AppUserAuthRemoteModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phoneNumber: json['phone'],
      address: json['address'],
      about: json['about'],
      userType: UserTypeExtension.fromString(json['user_type']),
      location: UserLocation(
        latitude: (json['latitude'] as num).toDouble(),
        longitude: (json['longitude'] as num).toDouble(),
      ),
      createdAt: DateTime.parse(json['created_at']),
      specialty: json['specialty'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phoneNumber,
      'user_type': userType.nameStr,
      'latitude': location.latitude,
      'longitude': location.longitude,
      if (specialty != null) 'specialty': specialty,
      if (address != null) 'address': address,
      if (about != null) 'about': about,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
