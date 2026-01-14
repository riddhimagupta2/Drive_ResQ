import 'package:drive_resq/controllers/ai_cont..dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DriverAiScreen extends StatelessWidget {
  const DriverAiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DriverAiController());

    return Scaffold(
      appBar: AppBar(title: const Text("AI Vehicle Assistant")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [

              // IMAGE
              Obx(() => controller.image.value == null
                  ? OutlinedButton(
                onPressed: controller.pickImage,
                child: const Text("Upload Vehicle Image"),
              )
                  : Image.file(controller.image.value!, height: 180)),

              const SizedBox(height: 12),

              // TEXT
              TextField(
                controller: controller.problemController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: "Describe the problem (optional)",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 12),

              // BUTTON
              ElevatedButton(
                onPressed: controller.askAi,
                child: const Text("Get AI Help"),
              ),

              const SizedBox(height: 20),

              // AI RESPONSE
              Obx(() => controller.aiResult.value.isNotEmpty
                  ? Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(controller.aiResult.value),
                ),
              )
                  : const SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}
