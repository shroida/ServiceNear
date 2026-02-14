import 'package:servicenear/common/entities/user_location.dart';
import 'package:servicenear/common/entities/user_type.dart';
import 'package:servicenear/common/entities/worker.dart';

class WorkerInfoModel extends Worker {
  const WorkerInfoModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.phoneNubmer,
    required super.email,
    required super.userType,
    required super.location,
    required super.createdAt,
    required super.rating,
    required super.reviewsCount,
    required super.about,
    required super.address,
  });

  factory WorkerInfoModel.fromJson(Map<String, dynamic> json) {
    return WorkerInfoModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phoneNubmer: json['phone'],
      email: json['email'],
      userType: UserType.values.firstWhere((e) => e.name == json['userType']),
      location: UserLocation.fromJson({
        'latitude': (json['latitude'] as num).toDouble(),
        'longitude': (json['longitude'] as num).toDouble(),
      }),
      createdAt: DateTime.parse(json['created_at']),
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewsCount: json['reviews_count'] ?? 0,
      about: json['about'] ?? '',
      address: json['address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'first_name': firstName,
    'last_name': lastName,
    'phone': phoneNubmer,
    'email': email,
    'userType': userType.name,
    'latitude': location.latitude,
    'longitude': location.longitude,
    'created_at': createdAt.toIso8601String(),
    'rating': rating,
    'reviews_count': reviewsCount,
    'about': about,
    'address': address,
  };
}
