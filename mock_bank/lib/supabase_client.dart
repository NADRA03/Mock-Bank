import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseManager {
  static final SupabaseClient client = SupabaseClient(
    'https://YOUR_SUPABASE_PROJECT_REF.supabase.co',
    'YOUR_SUPABASE_ANON_KEY', 
  );
}