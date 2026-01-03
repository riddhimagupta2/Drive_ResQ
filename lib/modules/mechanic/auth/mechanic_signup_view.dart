import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/auth_cont..dart';
import 'package:drive_resq/core/styles/font.dart';
import 'package:drive_resq/core/styles/style.dart';
import 'package:drive_resq/core/utility/validators.dart';
import 'package:drive_resq/widgets/d_text_field.dart';


class MechanicSignupView extends StatelessWidget {
  MechanicSignupView({super.key});

  final AuthController controller = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.08,
          vertical: height * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height * 0.12),
            Text(
              "Join as a Mechanic",
              style: AppTextStyles.header.copyWith(fontSize: 21),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              "Create your account and start assisting drivers nearby",
              style: AppTextStyles.subHeader,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),


            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.containerColor,
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.shadowColor,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Full Name
                    DTextField(
                      controller: nameCtrl,
                      label: "Full Name",
                      icon: Icons.person_outline,
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter your full name' : null,
                    ),
                    const SizedBox(height: 16),

                    // Email
                    DTextField(
                      controller: emailCtrl,
                      label: "Email Address",
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: Validators.email,
                    ),
                    const SizedBox(height: 16),

                    // Phone
                    DTextField(
                      controller: phoneCtrl,
                      label: "Phone Number",
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      validator: Validators.phone,
                    ),
                    const SizedBox(height: 16),

                    // Password
                    Obx(
                          () => DTextField(
                        controller: passwordCtrl,
                        label: "Password",
                        icon: Icons.lock_outline,
                        obscureText: controller.isPasswordHidden.value,
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isPasswordHidden.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                        validator: Validators.password,
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Register Button
                    Obx(
                          () => SizedBox(
                        width: double.infinity,
                        height: height * 0.06,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: controller.isLoading.value
                              ? null
                              : () {
                            if (_formKey.currentState!.validate()) {
                              controller.signup(
                                name: nameCtrl.text.trim(),
                                email: emailCtrl.text.trim(),
                                phone: phoneCtrl.text.trim(),
                                password: passwordCtrl.text.trim(),
                                role: 'mechanic',
                              );
                            }
                          },
                          child: controller.isLoading.value
                              ? const CircularProgressIndicator(color: Colors.white)
                              : Text('Register', style: AppTextStyles.button),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: AppTextStyles.subHeader,
                ),
                TextButton(
                  onPressed: () =>Get.offAllNamed( '/mechanic-login'),
                  child: Text("Login", style: AppTextStyles.link),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
