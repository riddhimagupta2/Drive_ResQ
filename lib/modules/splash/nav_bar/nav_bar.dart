import 'package:drive_resq/controllers/naav_cont..dart';
import 'package:drive_resq/modules/driver/ai_assistant/ai_screen.dart';
import 'package:drive_resq/modules/driver/driver_dashboard/driver_dashboard.dart';
import 'package:drive_resq/modules/driver/driver_profile/d_profile.dart';
import 'package:drive_resq/modules/driver/recharge/d_recharge.dart';
import 'package:drive_resq/modules/driver/request/request_his.dart';
import 'package:drive_resq/modules/mechanic/history/m_history.dart';
import 'package:drive_resq/modules/mechanic/mechanic_dashboard/m_dashboard.dart';
import 'package:drive_resq/modules/mechanic/mechanic_profile/m_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatelessWidget {
  final String userType;
  BottomNavBar({required this.userType});

  final NavController controller = Get.put(NavController());

  final mechanicScreens = [
    MechanicDashboard(),
    MechanicHistory(),
    MechanicProfile(),
  ];

  final driverScreens = [
    DriverDashboard(),
    RequestHistory(),
    DriverAiScreen(),
    DriverProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: userType == 'mechanic'
            ? mechanicScreens[controller.selectedIndex.value]
            : driverScreens[controller.selectedIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changeIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF00695C),
          unselectedItemColor: Colors.grey,
          selectedIconTheme: IconThemeData(
            color: const Color(0xFF00695C),
            size: 28,
          ),
          unselectedIconTheme: IconThemeData(color: Colors.grey, size: 25),
          items: userType == 'mechanic'
              ? [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.history),
                    label: 'History',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ]
              : [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.list_alt),
                    label: 'Request',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.message),
                    label: 'Chat',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
        ),
      ),
    );
  }
}
