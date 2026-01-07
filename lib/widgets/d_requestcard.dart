import 'dart:convert';
import 'dart:typed_data';
import 'package:drive_resq/models/request_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/driver_cont..dart';

class DriverRequestCard extends StatelessWidget {
  final RequestModel request;
  final Color primaryColor;

  const DriverRequestCard({
    super.key,
    required this.request,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    final lat = request.location?.lat ?? 'Unknown';
    final lng = request.location?.lng ?? 'Unknown';
    final landmark = request.location?.landmark ?? '';
    Uint8List? imageBytes;

    final String? firstImage =
    request.images.isNotEmpty ? request.images.first : null;

    if (firstImage != null &&
        !firstImage.startsWith("http") &&
        firstImage.length > 100) {
      try {
        imageBytes = base64Decode(firstImage);
      } catch (e) {
        debugPrint("Image decode error: $e");
      }
    }

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Active Rescue Request",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00695C),
              ),
            ),
            const SizedBox(height: 10),
            Text("📍 Location: $lat, $lng"),
            if (landmark.isNotEmpty) Text("📌 Landmark: $landmark"),
            if (request.description?.isNotEmpty ?? false)
              Text("📝 Problem: ${request.description}"),
            if (request.vehicleInfo?.isNotEmpty ?? false)
              Text("🚗 Vehicle: ${request.vehicleInfo}"),
            if (request.phone?.isNotEmpty ?? false)
              Text("📞 Phone: ${request.phone}"),
            const SizedBox(height: 10),
            if (firstImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: imageBytes != null
                    ? Image.memory(
                  imageBytes,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                )
                    : Image.network(
                  firstImage,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                  const Text("Invalid image data"),
                ),
              ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () async {
                    await Get.find<DriverRequestStatusController>()
                        .markCompleted(request.id!);
                    Get.snackbar("Completed", "Request marked as completed");
                  },
                  icon: const Icon(Icons.check_circle_outline,
                      color: Colors.green),
                  label: const Text("Complete",
                      style: TextStyle(color: Colors.green)),
                ),
                TextButton.icon(
                  onPressed: () async {
                    await Get.find<DriverRequestStatusController>()
                        .deleteRequest(request.id!);
                    Get.snackbar("Deleted", "Request removed successfully");
                  },
                  icon:
                  const Icon(Icons.delete_outline, color: Colors.redAccent),
                  label: const Text("Delete",
                      style: TextStyle(color: Colors.redAccent)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
