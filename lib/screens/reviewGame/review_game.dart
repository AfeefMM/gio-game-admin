// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gio_game_admin/screens/menu.dart';
import 'package:gio_game_admin/screens/updateGame/update_screen.dart';
import 'package:gio_game_admin/utils/dimensions.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';

import 'package:gio_game_admin/screens/reviewGame/review_tLabel.dart';

import '../../controllers/text_controller.dart';
import '../../model/gameFile.dart';
import '../../utils/api_service.dart';
import '../../utils/colours.dart';
import '../../widgets/textLabel.dart';

class ReviewPage extends StatefulWidget {
  @override
  State<ReviewPage> createState() => _ReviewPageState();
  final String title;
  final String fromDate;
  final String toDate;
  ReviewPage({
    Key? key,
    required this.title,
    required this.fromDate,
    required this.toDate,
  }) : super(key: key);
}

final textController = Get.put(TextController());

var staffName = Get.arguments[0];

//final gameData = <List<String>>[[]];

late var gameName, fromDate, toDate, gameArea, listOfShops, listOfVals, gameId;

class _ReviewPageState extends State<ReviewPage> {
  @override
  void initState() {
    // TODO: implement initState
    textController.isNumber = false;
    gameName = "";
    fromDate = "";
    toDate = "";
    gameArea = "";
    listOfShops = [];
    listOfVals = [];
    gameId = [];
    getSQLData();
    super.initState();
  }

  List<GameFile> gamesList = [];
  Future<void> getSQLData() async {
    try {
      gamesList = await ApiService().getGameFileData();
      Future.delayed(const Duration(seconds: 1))
          .then((value) => setState(() {}));

      String fdate = widget.fromDate.split('T')[0];
      String tdate = widget.toDate.split('T')[0];

      var numOfGames = gamesList.length; //number of games
      for (int i = 0; i < numOfGames; i++) {
        if (gamesList[i].gameName == widget.title &&
            gamesList[i].fromDate?.split('T')[0] == fdate &&
            gamesList[i].toDate?.split('T')[0] == tdate) {
          gameName = gamesList[i].gameName;
          fromDate = gamesList[i].fromDate?.split('T')[0];
          toDate = gamesList[i].toDate?.split('T')[0];
          gameArea = gamesList[i].areaName;
          listOfShops.add(gamesList[i].storeCode);
          listOfVals.add(gamesList[i].gameValue);
          gameId.add(gamesList[i].gameId);
          // print("cur data:" + gamesList[i].gameId.toString());
        }
      }
    } catch (e) {
      print(e);
    }
  }

  List<String> sideList = ["Update", "Delete", "Close"];

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
          actions: [
            //side bar for delete and update
            IconButton(
                onPressed: () {
                  showModalSideSheet(
                      // width: 700,
                      context: context,
                      ignoreAppBar: true,
                      body: ListView.builder(
                        itemCount: sideList.length,
                        itemBuilder: (context, index) {
                          Icon icon = Icon(Icons.delete);
                          String text = sideList[index];
                          if (index == 0) {
                            icon = Icon(Icons.update);
                          }
                          return GestureDetector(
                            onTap: () {
                              if (index == 0) {
                                //pass to update
                                print("update");
                                //add function to update controllers with values
                                Get.to(() => UpdatePage(
                                      title: gameName,
                                      fromDate: fromDate,
                                      toDate: toDate,
                                    ));
                              }
                              if (index == 1) {
                                //delete function and go to menu page
                                _showDialog("Confirm delete game?");
                              }
                              if (index == 2) {
                                icon = Icon(Icons.close);
                                Get.back();
                              }
                            },
                            child: ListTile(
                              leading: icon,
                              title: Text(text),
                            ),
                          );
                        },
                      ));
                },
                icon: const Icon(Icons.menu))
          ],
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
                    text: "Game Description",
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
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 1, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: Dimensions.height300,
                    width: Dimensions.screenWidth - 50,
                    child: GridView.count(
                      // Create a grid with 2 columns. If you change the scrollDirection to
                      // horizontal, this produces 2 rows.
                      crossAxisCount: 1,
                      padding: EdgeInsets.zero,
                      childAspectRatio: (Dimensions.screenWidth / 2) /
                          (Dimensions.screenHeight / 24),
                      // Generate 100 widgets that display their index in the List.
                      children: List.generate(listOfShops.length, (index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Text(code.customerName)
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
                              child: Row(
                                children: [
                                  TextLabel(
                                    text: listOfShops[index],
                                    color: AppColours.blueColour,
                                    size: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  const Text(" - "),
                                  TextLabel(
                                    text: listOfVals[index].toString(),
                                    color: AppColours.blueColour,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer()
          ],
        ));
  }

  void updateControllers() {
    setState(() {
      // textController.isFromSelected = true;
      // textController.updateMode = true;
      // textController.gameNameController.text = gameName;
      // textController.fromDate = DateTime.parse(fromDate);
      // textController.fromDate = DateTime.parse(toDate);
      // textController.shopAreaController.text = gameArea;
      // for (int i = 0; i < listOfShops.length; i++) {
      //   textController.addShopValue(listOfShops[i], listOfVals[i]);
      // }
    });
  }

  void deleteGame() async {
    try {
      // var db = textController.initiateDBConn();

      // var del = await db!.query(
      //     "delete from gio_game.game_file where game_name LIKE '${gameName}' AND from_date LIKE '${fromDate}' AND to_date LIKE '${toDate}'");

      // db.close();
      for (var i = 0; i < gameId.length; i++) {
        // TO DO
        ApiService().deleteGameFile(gameId[i]);
        // print(gameId[i]);
      }

      Get.off(() => MenuPage());
    } catch (e) {
      print(e);
    }
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
                deleteGame();

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
