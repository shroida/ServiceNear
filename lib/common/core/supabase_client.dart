import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseManager {
  static Future<void> init() async {
    await Supabase.initialize(
      url: 'https://ndjfumwifjhhyhjtlyzy.supabase.co',
      anonKey: 'sb_publishable_9lEDZWdud3TSeUn-j8O7tA_Ek5ogmhX',
    );
  }
}
