import 'dart:io';
import 'package:geocoding/geocoding.dart';
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
  var driverAddress = ''.obs;


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

      // 🔹 Convert lat/long → readable location
      final placemarks = await placemarkFromCoordinates(
        latitude.value,
        longitude.value,
      );

      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        driverAddress.value =
        '${p.subLocality}, ${p.locality}, ${p.administrativeArea}';
      }
    } catch (e) {
      driverAddress.value = 'Location unavailable';
      Get.snackbar("Error", e.toString());
    }
  }


  // 📸 Pick image (max 3)
  Future<void> pickImage() async {
    if (selectedImages.length >= 3) return;

    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      selectedImages.add(File(image.path));
    }
  }

  // ☁ Upload images to Supabase Storage
  Future<List<String>> uploadImages() async {
    List<String> imageUrls = [];

    for (final image in selectedImages) {
      final fileName =
          'requests/${_client.auth.currentUser!.id}_${DateTime.now().millisecondsSinceEpoch}.jpg';

      await _client.storage
          .from('request-images')
          .upload(fileName, image);

      final publicUrl = _client.storage
          .from('request-images')
          .getPublicUrl(fileName);

      imageUrls.add(publicUrl);
    }

    return imageUrls;
  }

  // 🚗 Submit roadside assistance request
  Future<void> submitRequest() async {
    if (problemText.isEmpty ||
        phoneText.isEmpty ||
        latitude.value == 0.0) {
      Get.snackbar("Validation", "Fill all required fields");
      return;
    }

    try {
      isSubmitting.value = true;

      String address = 'Location unavailable';
      try {
        final placemarks = await placemarkFromCoordinates(
          latitude.value,
          longitude.value,
        );

        if (placemarks.isNotEmpty) {
          final p = placemarks.first;
          address =
          '${p.subLocality}, ${p.locality}, ${p.administrativeArea}';
        }
      } catch (_) {}

      final imageUrls = await uploadImages();

      await _client.from('requests').insert({
        'driver_id': _client.auth.currentUser!.id,
        'description': problemText,
        'vehicle_info': landmarkText,
        'phone': phoneText,
        'status': 'pending',


        'driver_latitude': latitude.value,
        'driver_longitude': longitude.value,
        'driver_address': address,

        'images': imageUrls,
      });

      Get.snackbar("Success", "Request sent to mechanics");
      Get.back();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isSubmitting.value = false;
    }
  }
}
