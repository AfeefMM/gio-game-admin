import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mysql_utils/mysql_utils.dart';

import '../../../controllers/text_controller.dart';
import '../../../utils/colours.dart';
import '../../../utils/sql_data.dart';
import '../../menu.dart';

class CreateGameBtn extends StatefulWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  FontWeight fontWeight;
  String value;
  CreateGameBtn(
      {Key? key,
      this.color = AppColours.blueColour,
      required this.text,
      this.value = "",
      this.overflow = TextOverflow.ellipsis,
      this.fontWeight = FontWeight.w800,
      this.size = 0})
      : super(key: key);

  @override
  State<CreateGameBtn> createState() => _CreateGameBtnState();
}

bool confirmState = false;

class _CreateGameBtnState extends State<CreateGameBtn> {
  final textController = Get.put(TextController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(1, 5, 1, 10),
        child: ButtonTheme(
          minWidth: 200,
          child: OutlinedButton(
            onPressed: () async {
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

                var row = await db.query('SELECT * from game_file;');
                String fromDate = '';
                String toDate = '';
                String gameName = '';
                //shifted below from top of func
                bool gameExist = false;
                for (int i = 0; i < row.numOfRows; i++) {
                  var name = textController.gameNameController.text;
                  var from = textController.gameFromDateController.text;
                  var to = textController.gameToDateController.text;

                  fromDate = row.rows[i]["from_date"];
                  toDate = row.rows[i]["to_date"];
                  gameName = row.rows[i]["game_name"];

                  if (gameName == name && fromDate == from && toDate == to) {
                    // staffName = row.rows[i]['name'];
                    gameExist = true;
                  }
                }

                // print(gameExist.toString() + " " + confirmState.toString());
                if (!gameExist) {
                  _showDialog("Confirm create game? ", db);

                  setState(() {
                    confirmState = false;
                  });

                  //Get.to(() => MenuPage());
                }
                //insert row
                // await db.insert(
                //   table: 'table',
                //   debug: false,
                //   insertData: {
                //     'telphone': '+113888888888',
                //     'create_time': 1620577162252,
                //     'update_time': 1620577162252,
                //   },
                // );
              } catch (e) {
                print(e);
              }
            },
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(1, 13, 1, 13),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0)),
                backgroundColor: AppColours.blueColour,
                textStyle: const TextStyle(color: AppColours.btnTextColour)),
            child: Text(
              widget.text,
              style: const TextStyle(color: AppColours.btnTextColour),
            ),
          ),
        ));
  }

  void insertGame(db) async {
    for (int i = 0; i < textController.shops.value.length; i++) {
      var insertGame = await db.query(
          "INSERT INTO gio_game.game_file (game_name, from_date, to_date, store_code, game_value, area_name)" +
              "VALUES('${textController.gameNameController.text}', '${textController.gameFromDateController.text}', '${textController.gameToDateController.text}', '${textController.shops.value.elementAt(i).shopName}', ${textController.shops.value.elementAt(i).shopValue}, '${textController.shopAreaController.text}');");
      Get.to(() => MenuPage(),
          arguments: textController.staffNameController.text);
      print(insertGame.toString());
    }

    textController.staffPassController.clear();

    db.close();
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

  bool _isDialogShowing = false;

  void _showDialog(String text, db) {
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
                insertGame(db);
                setState(() {
                  confirmState = true;
                });

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
