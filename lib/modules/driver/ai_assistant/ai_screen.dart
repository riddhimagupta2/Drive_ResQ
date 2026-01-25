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
        title: const Text("DriveResQ AI"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [

                  /// USER IMAGE
                  Obx(() => controller.image.value != null
                      ? Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.file(
                          controller.image.value!,
                          height: 160,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                      : const SizedBox()),

                  /// USER MESSAGE
                  Obx(() => controller.userMessage.value.isNotEmpty
                      ? Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(12),
                      constraints: const BoxConstraints(maxWidth: 280),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        controller.userMessage.value,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  )
                      : const SizedBox()),

                  /// AI MESSAGE (CREATIVE ✨)
                  Obx(() => controller.aiResult.value.isNotEmpty
                      ? Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(14),
                      constraints: const BoxConstraints(maxWidth: 300),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.grey.shade100,
                            Colors.grey.shade50,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "DriveResQ AI",
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            controller.aiResult.value,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                      : const SizedBox()),

                  /// AI TYPING
                  Obx(() => controller.isLoading.value
                      ? const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "AI is analyzing…",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  )
                      : const SizedBox()),
                ],
              ),
            ),
          ),

          /// INPUT BAR
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            child: Row(
              children: [

                IconButton(
                  icon: const Icon(Icons.camera_alt_outlined),
                  onPressed: controller.pickImage,
                ),

                Expanded(
                  child: TextField(
                    controller: controller.problemController,
                    decoration: const InputDecoration(
                      hintText: "Message DriveResQ AI…",
                      border: InputBorder.none,
                    ),
                  ),
                ),

                Obx(() => IconButton(
                  icon: const Icon(Icons.send_rounded),
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.askAi,
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
