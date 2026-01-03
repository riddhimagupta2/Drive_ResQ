import 'package:get/get.dart';
import '../core/service/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  RxBool isLoading = false.obs;

  var isPasswordHidden = true.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }


  Future<void> signup({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String role,
  }) async {
    try {
      isLoading.value = true;

      await _authService.signUp(
        name: name,
        email: email,
        phone: phone,
        password: password,
        role: role,
      );

      if (role == 'driver') {
        Get.offAllNamed('/driver-dashboard');
      } else {
        Get.offAllNamed('/mechanic-dashboard');
      }

    } catch (e) {
      Get.snackbar('Signup Failed', e.toString());
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> login({
    required String email,
    required String password,
    String? expectedRole,
  }) async {
    try {
      isLoading.value = true;

      final role = await _authService.login(
        email: email,
        password: password,
      );

      if (expectedRole != null && role != expectedRole) {
        await _authService.logout();
        throw 'You are not registered as $expectedRole';
      }

      if (role == 'driver') {
        Get.offAllNamed('/driver-dashboard');
      } else {
        Get.offAllNamed('/mechanic-dashboard');
      }
    } catch (e) {
      Get.snackbar('Login Failed', e.toString());
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> checkLoginStatus() async {
    final role = await _authService.getUserRole();

    if (role == null) {
      Get.offAllNamed('/login');
    } else if (role == 'driver') {
      Get.offAllNamed('/driver-dashboard');
    } else {
      Get.offAllNamed('/mechanic-dashboard');
    }
  }


  Future<void> logout() async {
    await _authService.logout();
    Get.offAllNamed('/login');
  }
}
