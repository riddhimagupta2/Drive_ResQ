import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_cont..dart';


class MechanicSignupView extends StatelessWidget {
  final AuthController controller = Get.put(AuthController());

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('mechanic Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [

            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Name')),
            TextField(controller: emailCtrl, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: phoneCtrl, decoration: const InputDecoration(labelText: 'Phone')),
            TextField(controller: passwordCtrl, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),

            const SizedBox(height: 24),

            Obx(() => ElevatedButton(
              onPressed: controller.isLoading.value
                  ? null
                  : () {
                controller.signup(
                  name: nameCtrl.text.trim(),
                  email: emailCtrl.text.trim(),
                  phone: phoneCtrl.text.trim(),
                  password: passwordCtrl.text.trim(),
                  role: 'mechanic',
                );
              },
              child: controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : const Text('Register as mechanic'),
            )),
          ],
        ),
      ),
    );
  }
}
