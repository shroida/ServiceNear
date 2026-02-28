import 'package:servicenear/common/entities/user_location.dart';
import 'package:servicenear/common/entities/user_type.dart';

import 'app_user.dart';

class Worker extends AppUser {
  final String? specialty;
  final double rating;
  final int reviewsCount;
  final String? about;
  final String? phoneNubmer;
  final String address;

  const Worker({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.userType,
    required super.location,
    required super.createdAt,

    this.specialty,
    this.phoneNubmer,
    this.rating = 0.0,
    this.reviewsCount = 0,
    this.about = '',
    this.address = '',
  });
  factory Worker.fromMap(Map<String, dynamic> map) {
    return Worker(
      id: map['id']?.toString() ?? 'unknown-id',
      firstName: map['first_name'] ?? 'Unknown',
      lastName: map['last_name'] ?? 'Unknown',
      phoneNubmer: map['phone'] ?? 'Unknown',
      email: map['email'] ?? 'Unknown',
      specialty: map['specialty'] ?? 'Unknown',

      // 🔥 أهم تعديل هنا
      rating: (map['rating'] as num?)?.toDouble() ?? 0.0,

      reviewsCount: (map['reviews_count'] as num?)?.toInt() ?? 0,

      about: map['about'] ?? '',
      address: map['address'] ?? '',

      userType: UserTypeExtension.fromString(map['user_type'] ?? 'customer'),

      location: UserLocation.fromJson({
        // 🔥 مهم جدًا برضه
        'latitude': (map['latitude'] as num?)?.toDouble() ?? 0.0,
        'longitude': (map['longitude'] as num?)?.toDouble() ?? 0.0,
      }),

      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'])
          : DateTime.now(),
    );
  }
}
