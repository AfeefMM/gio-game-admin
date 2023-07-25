import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gio_game_admin/screens/createGame/createWidgets/textCreateField.dart';

import '../../controllers/text_controller.dart';
import '../../utils/colours.dart';
import '../../widgets/textLabel.dart';
import 'createWidgets/areaDropDown.dart';
import 'createWidgets/createDateWid.dart';
import 'select_shops.dart';

class CreateGamePageStep1 extends StatefulWidget {
  @override
  State<CreateGamePageStep1> createState() => _CreateGamePageStep1State();
}

final textController = Get.put(TextController());

var staffName = Get.arguments;

class _CreateGamePageStep1State extends State<CreateGamePageStep1> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  String capitalizeFirstLetter(String input) {
    if (input == null || input.isEmpty) {
      return '';
    }
    return input[0].toUpperCase() + input.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    //getSQLData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColours.blueColour,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        ),
      ),
      backgroundColor: AppColours.mainColor,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(1, 40, 1, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextLabel(
                    text: "Create Game",
                    size: 24,
                    color: AppColours.blueColour,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                CreateFields(
                    text: "Game Name",
                    controller: textController.gameNameController),
                CreateDate(
                    text: "From Date",
                    value: "from",
                    controller: textController.gameFromDateController),
                CreateDate(
                    text: "To Date",
                    value: "to",
                    controller: textController.gameToDateController),
                AreaDropDownBtn(
                  controller: textController.shopAreaController,
                ),
              ],
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(1, 5, 30, 30),
                    child: ButtonTheme(
                      minWidth: 300,
                      child: OutlinedButton(
                        onPressed: () async {
                          //onto next page
                          if (textController.shopAreaController != null) {
                            Get.to(() => SelectShopsPage(
                                  areaName:
                                      textController.shopAreaController.text,
                                ));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.fromLTRB(1, 13, 1, 13),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0)),
                            backgroundColor: AppColours.blueColour,
                            textStyle: const TextStyle(
                                color: AppColours.btnTextColour)),
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(10, 1, 10, 1),
                          child: Text(
                            "Select Shops",
                            style: TextStyle(
                                color: AppColours.btnTextColour,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
