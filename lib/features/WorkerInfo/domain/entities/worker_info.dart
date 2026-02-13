import 'package:servicenear/common/entities/app_user.dart';

class WorkerInfo extends AppUser {
  final double rating;
  final int reviewsCount;
  final String about;
  final String address;

  const WorkerInfo({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.phoneNubmer,
    required super.email,
    required super.userType,
    required super.location,
    required super.createdAt,
    required this.rating,
    required this.reviewsCount,
    required this.about,
    required this.address,
  });
}
