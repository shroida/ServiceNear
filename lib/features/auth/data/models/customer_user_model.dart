import '../../../../common/models/app_user_model.dart';

class CustomerUserAuthModel extends AppUserModel {
  CustomerUserAuthModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.userType,
    required super.location,
    required super.createdAt,
  });
}
