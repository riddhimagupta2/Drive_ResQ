import 'package:drive_resq/core/service/request_service.dart';
import 'package:drive_resq/models/request_model.dart';
import 'package:get/get.dart';

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

  void accept(String id) {
    _service.acceptRequest(id);
  }

  void reject(String id) {
    _service.rejectRequest(id);
  }
}
