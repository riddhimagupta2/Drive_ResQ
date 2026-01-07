import 'package:drive_resq/routes/app_page.dart';
import 'package:drive_resq/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/auth_cont..dart';
import 'controllers/role_cont..dart';
import 'core/supabase_config/supabase.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseConfig.init();
  Get.put(RoleController());// Initialize Supabase
  Get.put(AuthController(), permanent: true); // Initialize AuthController
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Mechanic Connect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
    );
  }
}