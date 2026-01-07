import 'package:drive_resq/controllers/auth_cont..dart';
import 'package:drive_resq/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MechanicProfile extends StatelessWidget {
  MechanicProfile({super.key});

  final AuthController authC = Get.find<AuthController>();

  final Color primaryColor = const Color(0xFF00695C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
      ),
      body: Obx(
        () => SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CircleAvatar(
                radius: 48,
                backgroundColor: primaryColor.withOpacity(0.1),
                child: Icon(Icons.person, size: 55, color: primaryColor),
              ),
              const SizedBox(height: 20),

              Text(
                authC.userName.value.isNotEmpty
                    ? authC.userName.value
                    : 'Mechanic',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),

              Text(
                authC.userEmail.value,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 6),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Mechanic',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              CustomField(
                icon: Icons.history,
                title: 'My History',
                subtitle: 'View all service requests',
                onTap: () => Get.toNamed('/driver-requests'),
              ),

              CustomField(
                icon: Icons.account_balance_wallet_outlined,
                title: 'Wallet',
                subtitle: 'Payments & history',
                onTap: () {},
              ),

              CustomField(
                icon: Icons.settings_outlined,
                title: 'Settings',
                subtitle: 'App preferences',
                onTap: () {},
              ),

              CustomField(
                icon: Icons.help_outline,
                title: 'Help & Support',
                subtitle: 'Need assistance?',
                onTap: () {},
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {
                  Get.defaultDialog(
                    title: 'Logout',
                    middleText: 'Are you sure you want to logout?',
                    textConfirm: 'Logout',
                    textCancel: 'Cancel',
                    confirmTextColor: Colors.white,
                    buttonColor: primaryColor,
                    onConfirm: () {
                      authC.logout();
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  'Log Out',
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
