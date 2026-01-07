import 'package:drive_resq/controllers/driver_cont..dart';
import 'package:drive_resq/routes/app_routes.dart';
import 'package:drive_resq/widgets/d_requestcard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriverDashboard extends StatelessWidget {
  const DriverDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DriverRequestStatusController());
    final Color primaryColor = const Color(0xFF00695C);
    final Color secondaryTextColor = Colors.grey.shade600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        leading: IconButton(
          icon: Icon(Icons.menu, color: secondaryTextColor),
          onPressed: () {},
        ),
        title: const Text(
          "DriveResQ",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: secondaryTextColor),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final requestId = await Get.toNamed(AppRoutes.newRequest);
          if (requestId != null) {
            controller.startListening(requestId);
          }
        },
        backgroundColor: primaryColor,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      body: Obx(() {
        final req = controller.request.value;

        if (req == null) {
          return _buildEmptyState(secondaryTextColor);
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: DriverRequestCard(request: req, primaryColor: primaryColor),
        );
      }),
    );
  }

  Widget _buildEmptyState(Color secondaryTextColor) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.car_repair_rounded,
            size: 100,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 24),
          const Text(
            "No active rescue requests yet",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            "When you need help, tap the '+' button\nto start a new request.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: secondaryTextColor),
          ),
        ],
      ),
    );
  }
}
