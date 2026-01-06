import 'package:drive_resq/models/request_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RequestService {
  final SupabaseClient _client = Supabase.instance.client;

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
        .map((data) => data.map((e) => RequestModel.fromMap(e)).toList());
  }

  Future<void> acceptRequest(String requestId) async {
    final mechanicId = _client.auth.currentUser!.id;

    await _client
        .from('requests')
        .update({'status': 'accepted', 'mechanic_id': mechanicId})
        .eq('id', requestId);
  }

  Future<void> rejectRequest(String requestId) async {
    await _client
        .from('requests')
        .update({'status': 'rejected'})
        .eq('id', requestId);
  }
}
