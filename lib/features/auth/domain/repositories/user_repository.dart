import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepository {
  final SupabaseClient supabase;

  UserRepository(this.supabase);

  /// Get current logged-in user ID from session
  String? getCurrentUserId() {
    final session = supabase.auth.currentSession;
    return session?.user.id;
  }

  /// Fetch full user data (customer or worker)
  Future<Map<String, dynamic>?> getCurrentUserData() async {
    final userId = getCurrentUserId();
    if (userId == null) return null;

    // Try to get customer first
    final customer = await supabase
        .from('customers')
        .select()
        .eq('id', userId)
        .maybeSingle();

    if (customer != null) {
      return Map<String, dynamic>.from(customer)..['user_type'] = 'customer';
    }

    // Try to get worker
    final worker = await supabase
        .from('workers')
        .select()
        .eq('id', userId)
        .maybeSingle();

    if (worker != null) {
      return Map<String, dynamic>.from(worker)..['user_type'] = 'worker';
    }

    return null;
  }
}
