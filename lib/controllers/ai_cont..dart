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

  // Pick image
  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      image.value = File(picked.path);
    }
  }

  // MAIN FUNCTION
  Future<void> askAi() async {
    if (image.value == null) {
      Get.snackbar("Error", "Please upload an image");
      return;
    }

    aiResult.value = "Analyzing problem...";

    // 1️⃣ Upload image
    final imageUrl = await uploadImage();

    // 2️⃣ Call AI function
    final response = await supabase.functions.invoke(
      'driver-ai',
      body: {
        'image_url': imageUrl,
        'problem': problemController.text,
      },
    );

    aiResult.value = response.data['answer'];
  }

  // Upload image to Supabase
  Future<String> uploadImage() async {
    final fileName = 'driver_ai/${DateTime.now().millisecondsSinceEpoch}.jpg';

    await supabase.storage
        .from('ai-images')
        .upload(fileName, image.value!);

    return supabase.storage
        .from('ai-images')
        .getPublicUrl(fileName);
  }
}
