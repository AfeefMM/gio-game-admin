import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class TextController extends GetxController {
  TextEditingController staffIDController = TextEditingController();
  TextEditingController staffPassController = TextEditingController();
  TextEditingController customerNameController = TextEditingController();
  TextEditingController customerNumberController = TextEditingController();
  TextEditingController productImgController = TextEditingController();
  TextEditingController currentIndexController = TextEditingController();

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
    customerNameController.addListener(() {
      controllerText.value = customerNameController.text;
    });
    customerNumberController.addListener(() {
      controllerText.value = customerNumberController.text;
    });
    productImgController.addListener(() {
      controllerText.value = productImgController.text;
    });
    currentIndexController.addListener(() {
      controllerText.value = productImgController.text;
    });
  }
}
