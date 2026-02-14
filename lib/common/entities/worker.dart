import 'app_user.dart';

class Worker extends AppUser {
  final String? specialty;
  final double rating;
  final int reviewsCount;
  final String about;
  final String address;

  const Worker({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.phoneNubmer,
    required super.email,
    required super.userType,
    required super.location,
    required super.createdAt,
    this.specialty,
    this.rating = 0.0,
    this.reviewsCount = 0,
    this.about = '',
    this.address = '',
  });
}
