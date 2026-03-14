import 'package:servicenear/common/entities/app_user.dart';
import 'package:servicenear/common/entities/user_location.dart';
import 'package:servicenear/common/entities/user_type.dart';

class AppUserModel extends AppUser {
  final String? specialty;
  final String? address;
  final String? about;
  final String? phoneNumber;

  const AppUserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.userType,
    required super.location,
    required super.createdAt,
    this.specialty,
    this.address,
    this.phoneNumber,
    this.about,
  });

  factory AppUserModel.fromJson(Map<String, dynamic> json) {
    return AppUserModel(
      id: json['id'],
      firstName: json['first_name'],
      phoneNumber: json['phone'],
      lastName: json['last_name'],
      email: json['email'],
      userType: UserTypeExtension.fromString(json['user_type']),
      location: UserLocation(
        latitude: (json['latitude'] as num).toDouble(),
        longitude: (json['longitude'] as num).toDouble(),
      ),
      createdAt: DateTime.parse(json['created_at']),
      specialty: json['specialty'],
      address: json['address'],
      about: json['about'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
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
