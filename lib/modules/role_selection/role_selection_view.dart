import 'package:drive_resq/widgets/role_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/role_cont..dart';

class RoleSelectionView extends StatelessWidget {
  final RoleController controller = Get.put(RoleController());
  RoleSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF00695C);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'DriveResQ',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Roadside help, on demand.',
                style: TextStyle(color: Colors.black54, fontSize: 16),
              ),

              const SizedBox(height: 50),

              RoleCard(
                icon: Icons.directions_car,
                title: "I'm a Driver",
                subtitle: 'Get nearby mechanics & live help',
                color: primaryColor,
                onTap: () => _showAuthOptions(context, 'driver', primaryColor),
              ),
              const SizedBox(height: 24),

              RoleCard(
                icon: Icons.build,
                title: "I'm a Mechanic",
                subtitle: 'Receive help requests in your area',
                color: primaryColor,
                onTap: () =>
                    _showAuthOptions(context, 'mechanic', primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAuthOptions(BuildContext context, String role, Color color) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Wrap(
          children: [
            Column(
              children: [
                Text(
                  'Welcome, ${role.capitalizeFirst}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),

                // LOGIN BUTTON
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                    if (role == 'driver') {
                      Get.offAllNamed('/driver-login');
                    } else {
                      Get.offAllNamed('/mechanic-login');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text(
                    'Log In',
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                const SizedBox(height: 16),

                // REGISTER BUTTON
                OutlinedButton(
                  onPressed: () {
                    Get.back();
                    if (role == 'driver') {
                      Get.offAllNamed('/driver-signup');
                    } else {
                      Get.offAllNamed('/mechanic-signup');
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: color),
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: Text(
                    'Register (New User)',
                    style: TextStyle(color: color),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
