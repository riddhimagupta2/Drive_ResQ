import 'package:drive_resq/core/supabase_config/supabase.dart';
import 'package:drive_resq/models/request_model.dart';
import 'package:supabase/supabase.dart';

class RequestService {
  final SupabaseClient _client = SupabaseConfig.client;

  Future<void> createRequest(RequestModel request) async {
    final driverId = _client.auth.currentUser!.id;

    await _client.from('requests').insert({
      'driver_id': driverId,
      ...request.toMap(),
      'status': 'pending',
    });
  }

  Stream<List<RequestModel>> listenPendingRequests() {
    return _client
        .from('requests')
        .stream(primaryKey: ['id'])
        .eq('status', 'pending')
        .map((data) => data.map(RequestModel.fromMap).toList());
  }

  Stream<RequestModel?> listenDriverRequest(String requestId) {
    return _client
        .from('requests')
        .stream(primaryKey: ['id'])
        .eq('id', requestId)
        .map(
          (data) => data.isNotEmpty ? RequestModel.fromMap(data.first) : null,
        );
  }

  Future<void> acceptRequest(String requestId, double lat, double lng) async {
    final mechanicId = _client.auth.currentUser!.id;

    await _client
        .from('requests')
        .update({
          'status': 'accepted',
          'mechanic_id': mechanicId,
          'mechanic_location': {'lat': lat, 'lng': lng},
        })
        .eq('id', requestId);
  }

  Future<void> rejectRequest(String requestId) async {
    await _client
        .from('requests')
        .update({'status': 'rejected'})
        .eq('id', requestId);
  }
}
