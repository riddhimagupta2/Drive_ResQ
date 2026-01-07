import 'package:drive_resq/modules/driver/driver_dashboard/driver_dashboard.dart';
import 'package:drive_resq/modules/driver/driver_profile/d_profile.dart';
import 'package:drive_resq/modules/driver/request/d_request.dart';
import 'package:drive_resq/modules/driver/request/request_his.dart';
import 'package:drive_resq/modules/mechanic/history/m_history.dart';
import 'package:drive_resq/modules/mechanic/mechanic_dashboard/m_dashboard.dart';
import 'package:drive_resq/modules/mechanic/mechanic_profile/m_profile.dart';
import 'package:drive_resq/modules/splash/splash.dart';
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
    GetPage(name: AppRoutes.splash, page: () => const Splash()),

    // Role Selection
    GetPage(name: AppRoutes.selectRole, page: () => RoleSelectionView()),

    // Driver Auth
    GetPage(name: AppRoutes.driverLogin, page: () => DriverLoginView()),
    GetPage(name: AppRoutes.driverSignup, page: () => DriverSignupView()),

    // Driver Dashboard
    GetPage(name: AppRoutes.driverHome, page: () => DriverDashboard()),
    GetPage(name: AppRoutes.newRequest, page: () => DriverRequest()),
    GetPage(name: AppRoutes.driverRequest, page: () => RequestHistory()),
    GetPage(name: AppRoutes.driverprofile, page: () => DriverProfile()),

    // Mechanic Auth
    GetPage(name: AppRoutes.mechanicLogin, page: () => MechanicLoginView()),
    GetPage(name: AppRoutes.mechanicSignup, page: () => MechanicSignupView()),

    // Mechanic Dashboard
    GetPage(name: AppRoutes.mechanicHome, page: () => MechanicDashboard()),
    GetPage(name: AppRoutes.history, page: () => MechanicHistory()),
    GetPage(name: AppRoutes.mechanicprofile, page: () => MechanicProfile()),

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
