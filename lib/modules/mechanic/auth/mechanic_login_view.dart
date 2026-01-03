import 'package:drive_resq/controllers/auth_cont..dart';
import 'package:drive_resq/core/styles/font.dart';
import 'package:drive_resq/core/utility/validators.dart';
import 'package:drive_resq/widgets/d_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:drive_resq/core/styles/style.dart';

class MechanicLoginView extends StatelessWidget {
  MechanicLoginView({super.key});

  final AuthController controller = Get.put(AuthController());
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.08,
            vertical: height * 0.15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.15),
              Text(
                "Welcome Back, Mechanic!",
                style: AppTextStyles.header,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Text(
                "Log in to start helping nearby customers",
                style: AppTextStyles.subHeader,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Login Form Container
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
                      DTextField(
                        controller: emailCtrl,
                        label: 'Email',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.email,
                      ),
                      const SizedBox(height: 16),
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
                            onPressed: () => controller
                                .togglePasswordVisibility(), // ✅ CALL method
                          ),
                          validator: Validators.password,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Login Button
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
                              controller.login(
                                email: emailCtrl.text.trim(),
                                password: passwordCtrl.text.trim(),
                                expectedRole: 'mechanic',
                              );
                            }
                          },
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text('Login', style: AppTextStyles.button),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Sign Up Redirect
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don’t have an account? ",
                    style: AppTextStyles.subHeader,
                  ),
                  TextButton(
                    onPressed: () => Get.offAllNamed('/mechanic-signup'),
                    child: Text("Sign Up", style: AppTextStyles.link),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
