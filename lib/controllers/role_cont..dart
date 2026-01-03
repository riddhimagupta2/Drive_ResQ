import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoleController extends GetxController {
  RxString selectedRole = ''.obs;

  void selectRole(String role) {
    selectedRole.value = role;
  }
}
