import '../../domain/entities/service.dart';

class ServiceModel extends Service {
  ServiceModel({
    super.id,
    required super.title,
    required super.description,
    required super.price,
    required super.specialty,
  });

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      id: map['id'],
      title: map['title'],
      description: map['description'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      specialty: map['specialty'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'price': price,
      'specialty': specialty,
    };
  }

  Service toEntity() => Service(
    id: id,
    description: description,
    title: title,
    specialty: specialty,
    price: price,
  );
}
