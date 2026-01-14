import 'dart:io';
import 'package:drive_resq/controllers/request_cont..dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DriverRequest extends StatelessWidget {
  DriverRequest({super.key});

  final RequestController controller = Get.put(RequestController());

  static const Color primaryColor = Color(0xFF00695C);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.latitude.value == 0.0) {
        controller.getCurrentLocation();
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: Get.back,
        ),
        title: Text(
          "New Rescue Request",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: primaryColor,
                      size: 30,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        controller.latitude.value == 0.0
                            ? "Fetching current location..."
                            : "${controller.driverAddress.value}\n",
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                    ),
                    TextButton(
                      onPressed: controller.getCurrentLocation,
                      child: const Text("Refresh"),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            Text(
              "Location Details",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              onChanged: (v) => controller.landmarkText = v,
              decoration: _inputDecoration(
                "Nearby Landmark (Optional)",
                Icons.pin_drop_outlined,
              ),
            ),

            const SizedBox(height: 24),

            Text(
              "Problem Details",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              maxLines: 4,
              onChanged: (v) => controller.problemText = v,
              decoration: _inputDecoration(
                "e.g., Engine won’t start, flat tyre...",
                Icons.report_problem_outlined,
              ),
            ),

            const SizedBox(height: 24),

            Text(
              "Contact Information",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              keyboardType: TextInputType.phone,
              onChanged: (v) => controller.phoneText = v,
              decoration: _inputDecoration(
                "Phone Number",
                Icons.phone_outlined,
              ),
            ),

            const SizedBox(height: 24),

            Text(
              "Add Photos (Max 3)",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),

            Obx(
              () => Row(
                children: [
                  ...controller.selectedImages.map((File file) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Stack(
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(file),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          Positioned(
                            top: 2,
                            right: 2,
                            child: GestureDetector(
                              onTap: () =>
                                  controller.selectedImages.remove(file),
                              child: const CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.black54,
                                child: Icon(
                                  Icons.close,
                                  size: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),

                  if (controller.selectedImages.length < 3)
                    GestureDetector(
                      onTap: controller.pickImage,
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.camera_alt_outlined),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(
          () => SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: controller.isSubmitting.value
                  ? null
                  : controller.submitRequest,
              child: controller.isSubmitting.value
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                      "Create Request",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  static InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
