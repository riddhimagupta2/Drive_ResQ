import 'package:drive_resq/modules/splash/nav_bar/nav_bar.dart';
import 'package:get/get.dart';
import '../core/service/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  final RxBool isLoading = false.obs;
  final RxBool isPasswordHidden = true.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.toggle();
  }

  // ================= SIGNUP =================
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

      await _waitForProfile();

      final fetchedRole = await _authService.getUserRole();
      if (fetchedRole == null) {
        throw 'Profile not created. Please login again.';
      }

      _navigateByRole(fetchedRole);

    } catch (e) {
      Get.snackbar('Signup Failed', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login({
    required String email,
    required String password,
    required String expectedRole,
  }) async {
    try {
      isLoading.value = true;

      await _authService.login(
        email: email,
        password: password,
      );

      await _waitForProfile();

      final role = await _authService.getUserRole();
      if (role == null) {
        throw 'Profile not found. Please contact support.';
      }

      if (role != expectedRole) {
        await _authService.logout();
        throw 'You are not registered as $expectedRole';
      }

      _navigateByRole(role);

    } catch (e) {
      Get.snackbar('Login Failed', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkLoginStatus() async {
    try {
      await _waitForProfile();

      final role = await _authService.getUserRole();
      if (role == null) {
        Get.offAllNamed('/login');
      } else {
        _navigateByRole(role);
      }
    } catch (_) {
      Get.offAllNamed('/login');
    }
  }

   Future<void> _waitForProfile() async {
    for (int i = 0; i < 5; i++) {
      final role = await _authService.getUserRole();
      if (role != null) return;
      await Future.delayed(const Duration(milliseconds: 300));
    }
  }

  void _navigateByRole(String role) {
    if (role == 'driver') {
      Get.offAll(() => BottomNavBar(userType: 'driver'));
    } else if (role == 'mechanic') {
      Get.offAll(() => BottomNavBar(userType: 'mechanic'));
    } else {
      Get.offAllNamed('/login');
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    Get.offAllNamed('/login');
  }
}
