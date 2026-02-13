import 'package:servicenear/common/entities/user_location.dart';
import 'package:servicenear/common/entities/user_type.dart';
import 'package:servicenear/features/WorkerInfo/domain/entities/worker_info.dart';

class WorkerInfoModel extends WorkerInfo {
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
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNubmer: json['phoneNubmer'],
      email: json['email'],
      userType: UserType.values.firstWhere((e) => e.name == json['userType']),
      location: UserLocation.fromJson(json['location']),
      createdAt: DateTime.parse(json['createdAt']),
      rating: json['rating']?.toDouble() ?? 0.0,
      reviewsCount: json['reviewsCount'] ?? 0,
      about: json['about'] ?? '',
      address: json['address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'firstName': firstName,
    'lastName': lastName,
    'phoneNubmer': phoneNubmer,
    'email': email,
    'userType': userType.name,
    'location': location.toJson(),
    'createdAt': createdAt.toIso8601String(),
    'rating': rating,
    'reviewsCount': reviewsCount,
    'about': about,
    'address': address,
  };
}
