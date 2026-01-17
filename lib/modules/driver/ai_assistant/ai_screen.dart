import 'package:drive_resq/controllers/ai_cont..dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DriverAiScreen extends StatelessWidget {
  const DriverAiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DriverAiController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Vehicle Assistant"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              Obx(() => controller.image.value == null
                  ? OutlinedButton.icon(
                icon: const Icon(Icons.camera_alt),
                label: const Text("Capture Vehicle Image"),
                onPressed: controller.pickImage,
              )
                  : ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  controller.image.value!,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              )),

              const SizedBox(height: 16),

              TextField(
                controller: controller.problemController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Describe the problem",
                  hintText: "e.g. Smoke coming from engine",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),

              Obx(() => ElevatedButton(
                onPressed:
                controller.isLoading.value ? null : controller.askAi,
                child: controller.isLoading.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Get AI Help"),
              )),

              const SizedBox(height: 20),

              Obx(() => controller.aiResult.value.isNotEmpty
                  ? Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    controller.aiResult.value,
                    style: const TextStyle(fontSize: 15),
                  ),
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
