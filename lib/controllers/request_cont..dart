import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RequestController extends GetxController {
  final SupabaseClient _client = Supabase.instance.client;
  final ImagePicker _picker = ImagePicker();

  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var isSubmitting = false.obs;
  var selectedImages = <File>[].obs;

  String landmarkText = '';
  String problemText = '';
  String phoneText = '';

  Future<void> getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar("Location Error", "Enable location services");
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.snackbar("Permission", "Location permission denied");
          return;
        }
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      latitude.value = position.latitude;
      longitude.value = position.longitude;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> pickImage() async {
    if (selectedImages.length >= 3) return;

    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      selectedImages.add(File(image.path));
    }
  }

  Future<List<String>> uploadImages() async {
    List<String> imageUrls = [];

    for (final image in selectedImages) {
      final fileName =
          'requests/${_client.auth.currentUser!.id}_${DateTime.now().millisecondsSinceEpoch}.jpg';

      await _client.storage.from('request-images').upload(fileName, image);

      final publicUrl = _client.storage
          .from('request-images')
          .getPublicUrl(fileName);

      imageUrls.add(publicUrl);
    }

    return imageUrls;
  }

  Future<void> submitRequest() async {
    if (problemText.isEmpty || phoneText.isEmpty || latitude.value == 0) {
      Get.snackbar("Validation", "Fill all required fields");
      return;
    }

    try {
      isSubmitting.value = true;

      final imageUrls = await uploadImages();

      await _client.from('requests').insert({
        'driver_id': _client.auth.currentUser!.id,
        'description': problemText,
        'vehicle_info': landmarkText,
        'phone': phoneText,
        'status': 'pending',
        'location': {'lat': latitude.value, 'lng': longitude.value},
        'images': imageUrls,
      });

      Get.snackbar("Success", "Request sent to mechanics");
      Get.back;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isSubmitting.value = false;
    }
  }
}
