import 'package:drive_resq/modules/mechanic/dashboard.dart';
import 'package:get/get.dart';
import '../modules/driver/auth/driver_login_view.dart';
import '../modules/driver/auth/driver_signup_view.dart';
import '../modules/mechanic/auth/mechanic_login_view.dart';
import '../modules/mechanic/auth/mechanic_signup_view.dart';
import '../modules/role_selection/role_selection_view.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    // Splash Screen
    //GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),

    // Role Selection
    GetPage(name: AppRoutes.selectRole, page: () => RoleSelectionView()),

    // Driver Auth
    GetPage(name: AppRoutes.driverLogin, page: () => DriverLoginView()),
    GetPage(name: AppRoutes.driverSignup, page: () => DriverSignupView()),

    // Driver Dashboard
    // GetPage(name: AppRoutes.driverHome, page: () => DriverHome()),
    // GetPage(name: AppRoutes.newRequest, page: () => const NewRequestScreen()),

    // Mechanic Auth
    GetPage(name: AppRoutes.mechanicLogin, page: () => MechanicLoginView()),
    GetPage(name: AppRoutes.mechanicSignup, page: () => MechanicSignupView()),

    // Mechanic Dashboard
     GetPage(name: AppRoutes.driverHome, page: () => Dashboard()),

    // Request Details
    // GetPage(
    //   name: AppRoutes.requestDetail,
    //   page: () {
    //     final RequestModel req = Get.arguments as RequestModel;
    //     return RequestDetailPage();
    //   },
    // ),
  ];
}
