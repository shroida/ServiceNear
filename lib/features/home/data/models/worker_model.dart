import 'package:servicenear/common/entities/user_location.dart';
import 'package:servicenear/common/entities/user_type.dart';
import 'package:servicenear/common/entities/worker.dart';

class WorkerModel extends Worker {
  WorkerModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.userType,
    required super.location,
    required super.phoneNumber,
    required super.createdAt,
    required super.specialty,
    required super.about,
    required super.address,
    required super.rating,
    required super.reviewsCount,
  });

  factory WorkerModel.fromMap(Map<String, dynamic> map) {
    return WorkerModel(
      id: map['id']?.toString() ?? 'unknown-id',
      firstName: map['first_name'] ?? 'Unknown',
      lastName: map['last_name'] ?? 'Unknown',
      phoneNumber: map['phone'] ?? 'Unknown',
      email: map['email'] ?? 'no-email@example.com',
      userType: UserTypeExtension.fromString(map['user_type'] ?? 'customer'),
      location: UserLocation.fromJson(map),
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'])
          : DateTime.now(),
      specialty: map['specialty'],
      about: map['about'] ?? '',
      address: map['address'] ?? '',
      rating: (map['rating'] != null)
          ? double.tryParse(map['rating'].toString()) ?? 0.0
          : 0.0,
      reviewsCount: map['reviews_count'] ?? 0,
    );
  }
}
