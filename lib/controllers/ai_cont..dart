import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

class DriverAiController extends GetxController {
  final picker = ImagePicker();
  final supabase = Supabase.instance.client;

  var image = Rx<File?>(null);
  var aiResult = "".obs;

  final problemController = TextEditingController();

  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      image.value = File(picked.path);
    }
  }

  Future<void> askAi() async {
    if (image.value == null) {
      Get.snackbar("Error", "Please upload an image");
      return;
    }

    if (problemController.text.trim().isEmpty) {
      Get.snackbar("Error", "Please describe the problem");
      return;
    }

    aiResult.value = "Analyzing problem...";

    try {
      final imageUrl = await uploadImage();

      final response = await supabase.functions.invoke(
        'ai-assistant',
        body: {'imageUrl': imageUrl, 'problem': problemController.text},
      );

      if (response.error != null) {
        throw response.error!;
      }

      final data = response.data as Map<String, dynamic>;
      final fixes = List<String>.from(data['quick_fixes']);

      aiResult.value =
          "Issue: ${data['issue']}\n\n"
          "Explanation: ${data['explanation']}\n\n"
          "Quick Fixes:\n- ${fixes.join('\n- ')}";
    } catch (e) {
      aiResult.value = "Something went wrong. Try again.";
      debugPrint(e.toString());
    }
  }

  Future<String> uploadImage() async {
    final fileName = 'issues/${DateTime.now().millisecondsSinceEpoch}.jpg';

    await supabase.storage
        .from('ai-images')
        .upload(
          fileName,
          image.value!,
          fileOptions: const FileOptions(contentType: 'image/jpeg'),
        );

    return supabase.storage.from('ai-images').getPublicUrl(fileName);
  }
}
