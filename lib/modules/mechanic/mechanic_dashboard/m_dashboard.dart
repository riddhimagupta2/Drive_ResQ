import 'package:drive_resq/controllers/mechanic_cont..dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MechanicDashboard extends StatelessWidget {
  const MechanicDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MechanicController());

    return Scaffold(
      appBar: AppBar(title: const Text("Mechanic Dashboard")),
      body: Obx(() {
        if (controller.requests.isEmpty) {
          return const Center(child: Text("No pending requests"));
        }

        return ListView.builder(
          itemCount: controller.requests.length,
          itemBuilder: (_, index) {
            final req = controller.requests[index];

            return Card(
              elevation: 3,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                title: Text(req.description ?? ''),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Vehicle: ${req.vehicleInfo}"),
                    Text("Phone: ${req.phone}"),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () => controller.reject(req.id!),
                    ),
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed: () => controller.accept(req.id!),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
