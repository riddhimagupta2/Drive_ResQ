import 'package:supabase/supabase.dart';
import '../supabase_config/supabase.dart';

class AuthService {
  final SupabaseClient _client = SupabaseConfig.client;


  Future<void> signUp({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String role,
  }) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
      data: {
        'name': name,
        'phone': phone,
        'role': role,
      },
    );

    final user = response.user;
    if (user == null) {
      throw 'Signup failed. User not created.';
    }

    await _client.from('profiles').upsert({
      'id': user.id,
      'name': name,
      'phone': phone,
      'role': role,
    });
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    final response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.user == null) {
      throw 'Invalid email or password';
    }
  }


  Future<String?> getUserRole() async {
    final user = _client.auth.currentUser;
    if (user == null) return null;

    final profile = await _client
        .from('profiles')
        .select('role')
        .eq('id', user.id)
        .maybeSingle();

    if (profile == null) return null;
    return profile['role'] as String?;
  }

  Future<void> logout() async {
    await _client.auth.signOut();
  }
}
