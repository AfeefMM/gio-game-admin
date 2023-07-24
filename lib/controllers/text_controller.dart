import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class TextController extends GetxController {
  TextEditingController staffIDController = TextEditingController();
  TextEditingController staffPassController = TextEditingController();
  TextEditingController gameNameController = TextEditingController();
  TextEditingController gameFromDateController = TextEditingController();
  TextEditingController gameToDateController = TextEditingController();
  TextEditingController shopAreaController = TextEditingController();

  RxString controllerText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    staffIDController.addListener(() {
      controllerText.value = staffIDController.text;
    });
    staffPassController.addListener(() {
      controllerText.value = staffPassController.text;
    });
    gameNameController.addListener(() {
      controllerText.value = gameNameController.text;
    });
    gameFromDateController.addListener(() {
      controllerText.value = gameFromDateController.text;
    });
    gameToDateController.addListener(() {
      controllerText.value = gameToDateController.text;
    });
    shopAreaController.addListener(() {
      controllerText.value = shopAreaController.text;
    });
  }
}
