import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

class DriverAiController extends GetxController {
  final ImagePicker picker = ImagePicker();
  final SupabaseClient supabase = Supabase.instance.client;

  var image = Rx<File?>(null);
  var aiResult = "".obs;
  var isLoading = false.obs;

  final problemController = TextEditingController();

  Future<void> pickImage() async {
    final picked = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 70,
    );

    if (picked != null) {
      image.value = File(picked.path);
    }
  }

  Future<void> askAi() async {
    if (image.value == null) {
      Get.snackbar("Error", "Please upload a vehicle image");
      return;
    }

    if (problemController.text.trim().isEmpty) {
      Get.snackbar("Error", "Please describe the problem");
      return;
    }

    try {
      isLoading.value = true;
      aiResult.value = "";

      final imageUrl = await uploadImage();

      final response = await supabase.functions.invoke(
        'ai-assistant',
        body: {
          'imageUrl': imageUrl,
          'problem': problemController.text.trim(),
        },
      );

      final data = response.data as Map<String, dynamic>;

      aiResult.value =
      "🛠 Issue:\n${data['issue']}\n\n"
          "📋 Explanation:\n${data['explanation']}\n\n"
          "📞 Call Mechanic: ${data['call_mechanic'] ? 'Yes' : 'No'}";

    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Error", "AI analysis failed");
    } finally {
      isLoading.value = false;
    }
  }

  Future<String> uploadImage() async {
    final fileName = 'issues/${DateTime.now().millisecondsSinceEpoch}.jpg';

    await supabase.storage.from('ai-images').upload(
      fileName,
      image.value!,
      fileOptions: const FileOptions(
        contentType: 'image/jpeg',
        upsert: false,
      ),
    );

    return supabase.storage.from('ai-images').getPublicUrl(fileName);
  }

  @override
  void onClose() {
    problemController.dispose();
    super.onClose();
  }
}
