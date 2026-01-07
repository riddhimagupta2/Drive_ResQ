import 'package:drive_resq/controllers/role_cont..dart';
import 'package:drive_resq/core/supabase_config/supabase.dart';
import 'package:drive_resq/modules/splash/nav_bar/nav_bar.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../routes/app_routes.dart';

class SplashController extends GetxController {
  final SupabaseClient _client = SupabaseConfig.client;
  final RoleController roleController = Get.find();

  @override
  void onReady() {
    super.onReady();
    _handleRedirect();
  }

  Future<void> _handleRedirect() async {
    final user =  _client.auth.currentUser;

    if (user == null) {
      Get.offAllNamed(AppRoutes.selectRole);
      return;
    }

    await roleController.fetchUserRole();

    if (roleController.role.value == 'driver') {
      Get.offAll(() => BottomNavBar(userType: 'driver'));
    } else if (roleController.role.value == 'mechanic') {
      Get.offAll(() => BottomNavBar(userType: 'mechanic'));
    } else {
      Get.offAllNamed(AppRoutes.selectRole);
    }
  }
}
