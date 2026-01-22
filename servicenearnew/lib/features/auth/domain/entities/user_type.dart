enum UserType { customer, worker }

extension UserTypeExtension on UserType {
  String get nameStr => this == UserType.worker ? 'worker' : 'customer';

  static UserType fromString(String value) =>
      value == 'worker' ? UserType.worker : UserType.customer;
}
