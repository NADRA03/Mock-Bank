import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseManager {
  static final SupabaseClient client = SupabaseClient(
    'https://zjcwhjdeljaygjulvgcx.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpqY3doamRlbGpheWdqdWx2Z2N4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ4MTA2MzQsImV4cCI6MjA3MDM4NjYzNH0.nWYO8lN8dzg2cn19ghj4VCdNnTDA1p9F7PHxkGEJ2ik', 
  );
}