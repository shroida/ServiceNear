import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseManager {
  static final SupabaseClient client = SupabaseClient(
    'https://ndjfumwifjhhyhjtlyzy.supabase.co',
    'sb_publishable_9lEDZWdud3TSeUn-j8O7tA_Ek5ogmhX',
  );

  static Future<void> init() async {
    await Supabase.initialize(
      url: 'https://ndjfumwifjhhyhjtlyzy.supabase.co',
      anonKey: 'sb_publishable_9lEDZWdud3TSeUn-j8O7tA_Ek5ogmhX',
    );
  }
}
