import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

class DriverAiController extends GetxController {
  final ImagePicker picker = ImagePicker();
  final SupabaseClient supabase = Supabase.instance.client;

  /// Reactive states
  var image = Rx<File?>(null);
  var aiResult = ''.obs;
  var isLoading = false.obs;
  var userMessage = ''.obs; // ✅ for chat-style UI

  /// Text controller (NOT reactive)
  final problemController = TextEditingController();

  /// 📷 Pick image from camera
  Future<void> pickImage() async {
    final picked = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 70,
    );

    if (picked != null) {
      image.value = File(picked.path);
    }
  }

  /// 🤖 Ask AI
  Future<void> askAi() async {
    final problemText = problemController.text.trim();

    if (image.value == null) {
      Get.snackbar("Error", "Please upload a vehicle image");
      return;
    }

    if (problemText.isEmpty) {
      Get.snackbar("Error", "Please describe the problem");
      return;
    }

    try {
      /// Save user message for chat bubble
      userMessage.value = problemText;

      isLoading.value = true;
      aiResult.value = '';

      /// Upload image
      final imageUrl = await uploadImage();

      /// Call Supabase Edge Function
      final response = await supabase.functions.invoke(
        'ai-assistant',
        body: {
          'imageUrl': imageUrl,
          'problem': problemText,
        },
      );

      final data = response.data as Map<String, dynamic>;

      /// Format AI response (GPT-like text)
      aiResult.value =
      "🛠 Issue:\n${data['issue']}\n\n"
          "📋 Explanation:\n${data['explanation']}\n\n"
          "📞 Call Mechanic: ${data['call_mechanic'] ? 'Yes' : 'No'}";

      /// Clear input after send (like ChatGPT)
      problemController.clear();

    } catch (e) {
      debugPrint("AI Error: $e");
      Get.snackbar("Error", "AI analysis failed");
    } finally {
      isLoading.value = false;
    }
  }

  /// ☁️ Upload image to Supabase Storage
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
