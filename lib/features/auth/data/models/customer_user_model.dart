import 'package:servicenear/features/auth/data/models/app_user_model.dart';

class CustomerUserModel extends AppUserModel {
  CustomerUserModel(
      {required super.id,
      required super.firstName,
      required super.lastName,
      required super.email,
      required super.userType,
      required super.location,
      required super.createdAt});
}
