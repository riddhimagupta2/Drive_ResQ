import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_cont..dart';


class MechanicLoginView extends StatelessWidget {
  final AuthController controller = Get.put(AuthController());

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mechanic Login')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [

            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(labelText: 'Email'),
            ),

            TextField(
              controller: passwordCtrl,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),

            const SizedBox(height: 24),

            Obx(() => ElevatedButton(
              onPressed: controller.isLoading.value
                  ? null
                  : () {
                controller.login(
                  email: emailCtrl.text.trim(),
                  password: passwordCtrl.text.trim(),
                  expectedRole: 'mechanic',
                );
              },
              child: controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : const Text('Login as Mechanic'),
            )),

            TextButton(
              onPressed: () => Get.toNamed('/mechanic-signup'),
              child: const Text('New Mechanic? Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
