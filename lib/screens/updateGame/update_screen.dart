// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gio_game_admin/screens/updateGame/update_btn.dart';
import 'package:mysql_utils/mysql_utils.dart';

import 'package:gio_game_admin/screens/reviewGame/review_tLabel.dart';

import '../../controllers/text_controller.dart';
import '../../model/gameFile.dart';
import '../../utils/api_service.dart';
import '../../utils/colours.dart';
import '../../utils/sql_data.dart';
import '../../widgets/textLabel.dart';
import 'update_textF.dart';

class UpdatePage extends StatefulWidget {
  @override
  State<UpdatePage> createState() => _UpdatePageState();
  final String title;
  final String fromDate;
  final String toDate;
  UpdatePage({
    Key? key,
    required this.title,
    required this.fromDate,
    required this.toDate,
  }) : super(key: key);
}

final textController = Get.put(TextController());
List<TextEditingController> _shopValController = [];

var shopList = [];

var staffName = Get.arguments[0];

//final gameData = <List<String>>[[]];

late var gameName, fromDate, toDate, gameArea, listOfShops, listOfVals;

class _UpdatePageState extends State<UpdatePage> {
  @override
  void initState() {
    // TODO: implement initState
    textController.isNumber = true;
    gameName = "";
    fromDate = "";
    toDate = "";
    gameArea = "";
    listOfShops = [];
    listOfVals = [];
    getSQLData();
    super.initState();
  }

  Future<void> getSQLData() async {
    try {
      List<GameFile> gamesList = [];
      gamesList = await ApiService().getGameFileData();
      Future.delayed(const Duration(seconds: 1))
          .then((value) => setState(() {}));

      String fdate = widget.fromDate.split('T')[0];
      String tdate = widget.toDate.split('T')[0];

      var numOfGames = gamesList.length; //number of games
      for (int i = 0; i < numOfGames; i++) {
        if (gamesList[i].gameName == widget.title &&
            gamesList[i].fromDate!.split('T')[0] == fdate &&
            gamesList[i].toDate!.split('T')[0] == tdate) {
          gameName = gamesList[i].gameName;
          fromDate = gamesList[i].fromDate!.split('T')[0];
          toDate = gamesList[i].toDate!.split('T')[0];
          gameArea = gamesList[i].areaName;
          listOfShops.add(gamesList[i].storeCode);
          listOfVals.add(gamesList[i].gameValue);

          // listOfShops.add(row.rows[i]['store_code']) = ; //need area name
        }
      }
    } catch (e) {
      print(e);
    }
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(1, 40, 1, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextLabel(
                    text: "Update Game",
                    size: 24,
                    color: AppColours.blueColour,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            ReviewText(text: gameName, textTitle: "Game Name: "),
            ReviewText(
                text: "${fromDate}".split(' ')[0], textTitle: "From Date: "),
            ReviewText(text: "${toDate}".split(' ')[0], textTitle: "To Date: "),
            ReviewText(text: gameArea, textTitle: "Area: "),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 1, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextLabel(
                        text: "Shops:",
                        color: AppColours.blueColour,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: listOfShops.length,
              itemBuilder: (context, index) {
                _shopValController.add(TextEditingController());
                print("shop name: " + listOfShops[index]);
                print("shop val: " + listOfVals[index].toString());

                textController.gameNameController.text = gameName;
                textController.shopAreaController.text = gameArea;
                textController.gameFromDateController.text =
                    "${fromDate}".split(' ')[0];
                textController.gameToDateController.text =
                    "${toDate}".split(' ')[0];

                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(1, 1, 1, 20),
                          child: TextLabel(
                            text: listOfShops[index],
                            color: AppColours.blueColour,
                          ),
                        ),
                        UpdateTextF(
                            text: "0",
                            value: listOfShops[index].toString(),
                            shopVal: (listOfVals[index]).toString(),
                            controller: _shopValController[index]),
                      ],
                    ),
                  ],
                );
              },
            )),
            UpdateBtn(text: "Update"),
          ],
        ));
  }

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
                "Cancel",
                style: TextStyle(color: AppColours.btnTextColour),
              ),
              onPressed: () {
                _isDialogShowing =
                    false; // set it `false` since dialog is closed
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(1, 13, 1, 13),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0)),
                  backgroundColor: AppColours.blueColour,
                  textStyle: const TextStyle(color: AppColours.btnTextColour)),
              child: const Text(
                "Confirm",
                style: TextStyle(color: AppColours.btnTextColour),
              ),
              onPressed: () {
                _isDialogShowing =
                    false; // set it `false` since dialog is closed
              },
            ),
          ],
        );
      },
    );
  }
}
