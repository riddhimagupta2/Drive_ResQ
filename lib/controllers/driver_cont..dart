import 'package:drive_resq/core/supabase_config/supabase.dart';
import 'package:drive_resq/models/request_model.dart';
import 'package:drive_resq/core/service/request_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DriverRequestStatusController extends GetxController {
  final _service = RequestService();

  var request = Rxn<RequestModel>();
  var distanceKm = 0.0.obs;

  void startListening(String requestId) {
    _service.listenDriverRequest(requestId).listen((req) {
      request.value = req;
      if (req?.status == 'accepted') {
        _calculateDistance(req!);
      }
    });
  }

  void _calculateDistance(RequestModel req) {
    if (req.location == null || req.mechanicLocation == null) return;

    final meters = Geolocator.distanceBetween(
      req.location!.lat,
      req.location!.lng,
      req.mechanicLocation!.lat,
      req.mechanicLocation!.lng,
    );

    distanceKm.value = meters / 1000;
  }

  Future<void> deleteRequest(String requestId) async {
    try {
      final SupabaseClient _client = SupabaseConfig.client;
      await _client.from('requests').delete().eq('id', requestId);
      if (request.value?.id == requestId) {
        request.value = null;
      }
    } catch (e) {
      debugPrint("Delete request error: $e");
      Get.snackbar("Error", "Failed to delete request");
    }
  }

  Future<void> markCompleted(String requestId) async {
    try {
      final supabase = Supabase.instance.client;
      await supabase
          .from('requests')
          .update({'status': 'completed'})
          .eq('id', requestId);
    } catch (e) {
      debugPrint("Mark completed error: $e");
      Get.snackbar("Error", "Failed to mark request as completed");
    }
  }
}
