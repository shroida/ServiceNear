class UserLocation {
  final double latitude;
  final double longitude;
  final String? address;
  final String? city;

  const UserLocation({
    required this.latitude,
    required this.longitude,
    this.address,
    this.city,
  });

  factory UserLocation.fromJson(Map<String, dynamic> json) {
    return UserLocation(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'],
      city: json['city'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'city': city,
    };
  }
}
