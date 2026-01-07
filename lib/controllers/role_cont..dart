import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RoleController extends GetxController {

  final RxString role = ''.obs;

  void selectRole(String value) {
    role.value = value;
  }


  Future<void> fetchUserRole() async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      role.value = '';
      return;
    }

    final data = await Supabase.instance.client
        .from('profiles')
        .select('role')
        .eq('id', user.id)
        .maybeSingle();

    role.value = data?['role'] ?? '';
  }
}
