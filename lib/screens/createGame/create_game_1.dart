// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gio_game_admin/model/gameFile.dart';
import 'package:gio_game_admin/utils/api_service.dart';

import '../../controllers/text_controller.dart';
import '../../utils/colours.dart';
import '../../widgets/textLabel.dart';
import 'createWidgets/areaDropDown.dart';
import 'createWidgets/createDateWid.dart';
import 'createWidgets/gamesDropDown.dart';
import 'select_shops.dart';

class CreateGamePageStep extends StatefulWidget {
  @override
  State<CreateGamePageStep> createState() => _CreateGamePageStepState();

  CreateGamePageStep({
    Key? key,
  }) : super(key: key);
}

final textController = Get.put(TextController());

var staffName = Get.arguments;

class _CreateGamePageStepState extends State<CreateGamePageStep> {
  @override
  void initState() {
    // TODO: implement initState
    if (!textController.updateMode) {
      textController.gameNameController.clear();
      textController.gameFromDateController.clear();
      textController.gameToDateController.clear();
      textController.shops.value.clear();
      textController.isFromSelected = false;
      textController.isToSelected = false;
      textController.shopAreaController.clear();
    }
    // textController.gameNameController.clear();
    // textController.gameFromDateController.clear();
    // textController.gameToDateController.clear();
    // textController.shops.value.clear();
    // textController.isFromSelected = false;
    // textController.isToSelected = false;
    // textController.shopAreaController.clear();
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
                // CreateFields(
                //     text: "Game Name",
                //     controller: textController.gameNameController),
                GameNameDropDownBtn(
                  controller: textController.gameNameController,
                ),
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
                          if (textController.gameNameController.text != "" &&
                              textController.gameFromDateController.text !=
                                  "" &&
                              textController.gameFromDateController.text !=
                                  "" &&
                              textController.shopAreaController.text != "" &&
                              compareDates()) {
                            if (!await gameExistChecker()) {
                              if (textController.shopAreaController.text !=
                                  "") {
                                Get.to(() => SelectShopsPage(
                                      areaName: textController
                                          .shopAreaController.text,
                                    ));
                              }
                            } else {
                              _showDialog(
                                  "Game already exists in same area and dates");
                            }
                          } else {
                            if (!compareDates()) {
                              _showDialog("To date cannot be before From date");
                            } else {
                              _showDialog("Missing fields, enter all details");
                            }
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

  Future<bool> gameExistChecker() async {
    try {
      List<GameFile> listOfGames = [];
      listOfGames = await ApiService().getGameFileData();
      Future.delayed(const Duration(seconds: 1))
          .then((value) => setState(() {}));

      String fromDate = '';
      String toDate = '';
      String gameName = '';
      String areaName = '';
      //shifted below from top of func
      bool gameExist = false;
      for (int i = 0; i < listOfGames.length; i++) {
        var name = textController.gameNameController.text;
        var from = textController.gameFromDateController.text;
        var to = textController.gameToDateController.text;
        var area = textController.shopAreaController.text;

        fromDate = listOfGames[i].fromDate!.split('T')[0];
        toDate = listOfGames[i].fromDate!.split('T')[0];
        gameName = listOfGames[i].gameName!;
        areaName = listOfGames[i].areaName!;

        if (gameName == name &&
            fromDate == from &&
            toDate == to &&
            areaName == area) {
          // staffName = row.rows[i]['name'];
          gameExist = true;
          return true;
        }
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  bool compareDates() {
    var fromD = textController.fromDate;
    var toD = textController.toDate;
    if (fromD.compareTo(toD) < 0) {
      print("is lesser");
      return true;
    } else if (fromD.compareTo(toD) >= 0) {
      return false;
    }
    return false;
  }

  // bool dateCompare(String from, String to) {
  //   // if (fromD.compareTo(toD) < 0) {
  //   //   print("true");
  //   //   return true;
  //   // }
  //   // _showDialog("From date is after To date");
  //   // print("false");
  //   return false;
  // }

  bool _isDialogShowing = false;
  void _showDialog(String text) {
    _isDialogShowing = true; // set it `true` since dialog is being displayed
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(text),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(1, 13, 1, 13),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0)),
                  backgroundColor: AppColours.blueColour,
                  textStyle: const TextStyle(color: AppColours.btnTextColour)),
              child: const Text(
                "Close",
                style: TextStyle(color: AppColours.btnTextColour),
              ),
              onPressed: () {
                _isDialogShowing =
                    false; // set it `false` since dialog is closed
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}

// DateTime dt1 = DateTime.parse("2021-12-23 11:47:00");
// DateTime dt2 = DateTime.parse("2018-02-27 10:09:00");

// if(dt1.compareTo(dt2) == 0){
//     print("Both date time are at same moment.");
// }

// if(dt1.compareTo(dt2) < 0){
//     print("DT1 is before DT2");
// }

// if(dt1.compareTo(dt2) > 0){
//     print("DT1 is after DT2");
// }