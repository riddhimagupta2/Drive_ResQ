import 'package:drive_resq/controllers/auth_cont..dart';
import 'package:drive_resq/core/utility/validators.dart';
import 'package:drive_resq/widgets/d_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:drive_resq/core/styles/style.dart';

class DriverLoginView extends StatelessWidget {
  DriverLoginView({super.key});

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
            vertical: height * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.15),
              Text(
                "Welcome Back, Driver!",
                style: AppTextStyles.header,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Text(
                "Log in to continue your journey",
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
                      DTextField(
                        controller: passwordCtrl,
                        label: 'Password',
                        icon: Icons.lock_outline,
                        obscureText: true,
                        validator: Validators.password,
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
                                expectedRole: 'driver',
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
                    onPressed: () => Get.offAllNamed('/driver-signup'),
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
