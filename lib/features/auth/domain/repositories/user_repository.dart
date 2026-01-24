import 'package:servicenear/features/auth/domain/entities/app_user.dart';
import 'package:servicenear/features/auth/domain/entities/customer_user.dart';
import 'package:servicenear/features/auth/domain/entities/user_location.dart';
import 'package:servicenear/features/auth/domain/entities/worker_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepository {
  final SupabaseClient supabase;

  UserRepository(this.supabase);

  String? getCurrentUserId() {
    final session = supabase.auth.currentSession;
    return session?.user.id;
  }

  Future<AppUser?> getCurrentUserData() async {
    final userId = getCurrentUserId();
    if (userId == null) return null;

    final customer = await supabase
        .from('customers')
        .select()
        .eq('id', userId)
        .maybeSingle();

    if (customer != null) {
      return CustomerUser(
        id: customer['id'],
        firstName: customer['first_name'],
        lastName: customer['last_name'],
        email: customer['email'],
        location: UserLocation(
          latitude: (customer['latitude'] as num).toDouble(),
          longitude: (customer['longitude'] as num).toDouble(),
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
      return WorkerUser(
        id: worker['id'],
        firstName: worker['first_name'],
        lastName: worker['last_name'],
        email: worker['email'],
        location: UserLocation(
          latitude: worker['latitude'],
          longitude: worker['longitude'],
        ),
        createdAt: worker['created_at'],
        specialty: worker['specialty'],
      );
    }

    return null;
  }
}
