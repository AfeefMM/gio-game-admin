import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mysql_utils/mysql_utils.dart';

import '../controllers/text_controller.dart';

import '../screens/menu.dart';
import '../utils/colours.dart';
import '../utils/sql_data.dart';

class LoginBtn extends StatefulWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  FontWeight fontWeight;
  String value;
  LoginBtn(
      {Key? key,
      this.color = AppColours.blueColour,
      required this.text,
      this.value = "",
      this.overflow = TextOverflow.ellipsis,
      this.fontWeight = FontWeight.w800,
      this.size = 0})
      : super(key: key);

  @override
  State<LoginBtn> createState() => _LoginBtnState();
}

class _LoginBtnState extends State<LoginBtn> {
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

                var row = await db.query('SELECT * from control_file;');
                String staffName = '';
                //print(row.rows[0]); //{game_id: 1, staff_id: 1012, qty: 2, amount: 350.0, score: 1}
                //print(row.rows[0]["staff_id"]); //1012 -> gives values
                bool flag = false;
                bool userExist = false;
                for (int i = 0; i < row.numOfRows; i++) {
                  var id = textController.staffIDController.text;
                  var pass = textController.staffPassController.text;
                  var sqlID = row.rows[i]["staff_id"];
                  var sqlPass = row.rows[i]["password"];
                  if (id == sqlID && pass == sqlPass) {
                    staffName = row.rows[i]['name'];
                    flag = true;
                  }
                  if (id == sqlID) {
                    userExist = true;
                  }
                }

                if (flag) {
                  db.close();
                  textController.staffPassController.clear();
                  Get.to(() => MenuPage(), arguments: staffName);
                } else if (userExist) {
                  _showDialog("Wrong password");
                } else {
                  _showDialog("User does not exist");
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
