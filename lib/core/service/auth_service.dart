import 'package:supabase/supabase.dart';
import '../supabase_config/supabase.dart';

class AuthService {
  final SupabaseClient _client = SupabaseConfig.client;

  // 🔐 SIGN UP WITH METADATA (SAFE)
  Future<void> signUp({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String role,
  }) async {
    try {
      await _client.auth.signUp(
        email: email,
        password: password,
        data: {
          'name': name,
          'phone': phone,
          'role': role,
        },
      );
    } on AuthException catch (e) {
      throw e.message;
    }
  }

  // 🔑 LOGIN
  Future<String> login({
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponse response =
      await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = response.user;
      if (user == null) throw 'Login failed';

      // Sync metadata → profiles (NOW user is authenticated)
      await syncProfileFromMetadata();

      final profile = await _client
          .from('profiles')
          .select('role')
          .eq('id', user.id)
          .maybeSingle();

      if (profile == null || profile['role'] == null) {
        throw 'Profile incomplete';
      }

      return profile['role'];
    } on AuthException catch (e) {
      throw e.message;
    }
  }

  // 🔁 SYNC METADATA → PROFILES
  Future<void> syncProfileFromMetadata() async {
    final user = _client.auth.currentUser;
    if (user == null) return;

    final meta = user.userMetadata ?? {};

    await _client.from('profiles').update({
      'name': meta['name'],
      'phone': meta['phone'],
      'role': meta['role'],
    }).eq('id', user.id);
  }

  // 🔎 GET ROLE
  Future<String?> getUserRole() async {
    final session = _client.auth.currentSession;
    if (session == null) return null;

    final profile = await _client
        .from('profiles')
        .select('role')
        .eq('id', session.user.id)
        .maybeSingle();

    return profile?['role'];
  }

  // 🚪 LOGOUT
  Future<void> logout() async {
    await _client.auth.signOut();
  }
}
