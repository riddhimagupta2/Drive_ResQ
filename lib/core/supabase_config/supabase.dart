import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static Future<void> init() async {
    await Supabase.initialize(
      url: 'https://ljzlwbamueahwhnojujd.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imxqemx3YmFtdWVhaHdobm9qdWpkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjE0MDA0NDcsImV4cCI6MjA3Njk3NjQ0N30.VxJ9RBKwP1aEUxRASTb2QyAw10z7PAQ4RDa0AN3fdUQ',
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}