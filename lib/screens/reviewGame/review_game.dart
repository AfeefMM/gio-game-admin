// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gio_game_admin/screens/menu.dart';
import 'package:gio_game_admin/screens/view_games.dart';
import 'package:gio_game_admin/utils/dimensions.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';
import 'package:mysql_utils/mysql_utils.dart';

import 'package:gio_game_admin/screens/reviewGame/review_tLabel.dart';

import '../../controllers/text_controller.dart';
import '../../utils/colours.dart';
import '../../utils/sql_data.dart';
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

late var gameName, fromDate, toDate, gameArea, listOfShops, listOfVals;

class _ReviewPageState extends State<ReviewPage> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  Future<void> getSQLData() async {
    try {
      var db = MysqlUtils(
          settings: {
            'host': SQLData.ip,
            'port': SQLData.port,
            'user': SQLData.username,
            'password': SQLData.password,
            'db': SQLData.databaseName,
            'maxConnections': 10,
            'secure': true,
            'prefix': 'prefix_',
            'pool': true,
            'collation': 'utf8mb4_general_ci',
            'sqlEscape': true,
          },
          errorLog: (error) {
            print(error);
          },
          sqlLog: (sql) {
            print(sql);
          },
          connectInit: (db1) async {
            print('whenComplete');
          });

      gameName = "";
      fromDate = "";
      toDate = "";
      gameArea = "";
      listOfShops = [];
      listOfVals = [];

      var row = await db.query('SELECT * from game_file;');
      var numOfGames = row.numOfRows; //number of games
      for (int i = 0; i < numOfGames; i++) {
        if (row.rows[i]['game_name'] == widget.title &&
            row.rows[i]['from_date'] == widget.fromDate &&
            row.rows[i]['to_date'] == widget.toDate) {
          gameName = row.rows[i]['game_name'];
          fromDate = row.rows[i]['from_date'];
          toDate = row.rows[i]['to_date'];
          gameArea = row.rows[i]['area_name'];
          listOfShops.add(row.rows[i]['store_code']);
          listOfVals.add(row.rows[i]['game_value']);

          // listOfShops.add(row.rows[i]['store_code']) = ; //need area name
        }
      }

      db.close();
      //print(row.rows[0]); //{game_id: 1, staff_id: 1012, qty: 2, amount: 350.0, score: 1}
      //print(row.rows[0]["staff_id"]); //1012 -> gives values
    } catch (e) {
      print(e);
    }
  }

  List<String> sideList = ["Update", "Delete"];

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
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          Icon icon = Icon(Icons.delete);
                          String text = "Delete";
                          if (index == 0) {
                            icon = Icon(Icons.update);
                            text = "Update";
                          }
                          return GestureDetector(
                            onTap: () {
                              if (index == 0) {
                                //pass to update
                                print("update");
                              }
                              if (index == 1) {
                                //delete function and go to menu page
                                _showDialog("Confirm delete game?");
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
        body: FutureBuilder(
          future: getSQLData(),
          builder: (context, snapshot) {
            return Column(
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
                    text: "${fromDate}".split(' ')[0],
                    textTitle: "From Date: "),
                ReviewText(
                    text: "${toDate}".split(' ')[0], textTitle: "To Date: "),
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
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 1, 5, 1),
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
            );
          },
        ));
  }

  void deleteGame() async {
    try {
      var db = textController.initiateDBConn();

      var del = await db!.query(
          "delete from gio_game.game_file where game_name LIKE '${gameName}' AND from_date LIKE '${fromDate}' AND to_date LIKE '${toDate}'");
      //modify query
      // var del = await db!
      //     .query("delete from game_file where game_id = ${widget.gameID}");
      db.close();

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
