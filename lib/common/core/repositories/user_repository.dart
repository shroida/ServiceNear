import 'package:servicenear/common/entities/app_user.dart';
import 'package:servicenear/common/entities/user_location.dart';
import 'package:servicenear/common/entities/user_type.dart';
import 'package:servicenear/common/entities/worker.dart';
import 'package:servicenear/features/auth/domain/entities/customer_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepository {
  final SupabaseClient supabase;

  UserRepository(this.supabase);

  String? get currentUserId => supabase.auth.currentUser?.id;

  Future<AppUser?> getCurrentUser() async {
    final id = currentUserId;
    if (id == null) return null;

    final customer = await supabase
        .from('customers')
        .select()
        .eq('id', id)
        .maybeSingle();

    if (customer != null) {
      return CustomerAuthUser(
        id: customer['id'],
        firstName: customer['first_name'],
        lastName: customer['last_name'],
        email: customer['email'],
        userType: UserType.customer,
        location: UserLocation(
          latitude: (customer['latitude'] as num).toDouble(),
          longitude: (customer['longitude'] as num).toDouble(),
        ),
        createdAt: DateTime.parse(customer['created_at']),
      );
    }

    final worker = await supabase
        .from('workers')
        .select()
        .eq('id', id)
        .maybeSingle();

    if (worker != null) {
      return Worker(
        id: worker['id'],
        firstName: worker['first_name'],
        lastName: worker['last_name'],
        email: worker['email'],
        userType: UserType.worker,
        location: UserLocation(
          latitude: (worker['latitude'] as num).toDouble(),
          longitude: (worker['longitude'] as num).toDouble(),
        ),
        createdAt: DateTime.parse(worker['created_at']),
        specialty: worker['specialty'],
        address: worker['address'],
        about: worker['about'],
      );
    }

    return null;
  }

  Future<AppUser?> getUserById(String userId) async {
    final customer = await supabase
        .from('customers')
        .select()
        .eq('id', userId)
        .maybeSingle();

    if (customer != null) {
      return CustomerAuthUser(
        id: customer['id'],
        userType: UserType.customer,
        firstName: customer['first_name'],
        lastName: customer['last_name'],
        email: customer['email'],
        location: UserLocation(
          latitude: (customer['latitude'] as num?)?.toDouble() ?? 0.0,
          longitude: (customer['longitude'] as num?)?.toDouble() ?? 0.0,
        ),
        createdAt: DateTime.parse(customer['created_at'] as String),
      );
    }

    final worker = await supabase
        .from('workers')
        .select()
        .eq('id', userId)
        .maybeSingle();

    if (worker != null) {
      return Worker(
        id: worker['id'],
        userType: UserType.worker,
        firstName: worker['first_name'],
        lastName: worker['last_name'],
        email: worker['email'],
        phoneNumber: worker['phone'],
        address: worker['address'],
        about: worker['about'],
        location: UserLocation(
          latitude: (worker['latitude'] as num?)?.toDouble() ?? 0.0,
          longitude: (worker['longitude'] as num?)?.toDouble() ?? 0.0,
        ),
        createdAt: DateTime.parse(worker['created_at'] as String),
        specialty: worker['specialty'],
      );
    }

    return null;
  }
}
