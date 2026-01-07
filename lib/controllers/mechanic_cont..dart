import 'package:drive_resq/core/service/request_service.dart';
import 'package:drive_resq/models/request_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class MechanicController extends GetxController {
  final RequestService _service = RequestService();
  var requests = <RequestModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _service.listenPendingRequests().listen((data) {
      requests.value = data;
    });
  }

  Future<void> accept(String id) async {
    final position = await Geolocator.getCurrentPosition();
    await _service.acceptRequest(id, position.latitude, position.longitude);
    Get.snackbar("Accepted", "Navigation started");
  }

  void reject(String id) => _service.rejectRequest(id);
}
