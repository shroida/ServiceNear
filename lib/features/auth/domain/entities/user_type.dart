enum UserType { customer, worker }

extension UserTypeExtension on UserType {
  String get nameStr => this == UserType.worker ? 'worker' : 'customer';

  static UserType fromString(String value) {
    switch (value) {
      case 'worker':
        return UserType.worker;
      case 'customer':
        return UserType.customer;
      default:
        throw Exception('Unknown UserType: $value');
    }
  }
}

final type = UserTypeExtension.fromString('worker');
