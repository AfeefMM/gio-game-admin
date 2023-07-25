import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../model/shop_model.dart';

class TextController extends GetxController {
  TextEditingController staffIDController = TextEditingController();
  TextEditingController staffPassController = TextEditingController();
  TextEditingController gameNameController = TextEditingController();
  TextEditingController gameFromDateController = TextEditingController();
  TextEditingController gameToDateController = TextEditingController();
  TextEditingController shopAreaController = TextEditingController();
  TextEditingController shopValueController = TextEditingController();
  TextEditingController staffNameController = TextEditingController();

  DateTime fromDate = DateTime(2017, 9, 7, 17);
  bool isFromSelected = false;
  bool isToSelected = false;
  DateTime toDate = DateTime(2017, 9, 7, 17);

  Rx<List<ShopModel>> shops = Rx<List<ShopModel>>([]);
  late ShopModel shopModel;
  var shopCount = 0.obs;

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
    shopValueController.addListener(() {
      controllerText.value = shopValueController.text;
    });
    staffNameController.addListener(() {
      controllerText.value = staffNameController.text;
    });
  }

  addShopValue(String name, int value) {
    shopModel = ShopModel(shopName: name, shopValue: value);
    shops.value.add(shopModel);
    shopCount.value = shops.value.length;
  }

  clearVals() {
    gameNameController.clear();
    gameFromDateController.clear();
    gameToDateController.clear();
    shops.value.clear();
    isFromSelected = false;
    isToSelected = false;
  }

  clearShop() {
    shops.value.clear();
  }
}
