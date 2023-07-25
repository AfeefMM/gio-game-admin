import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:gio_game_admin/screens/login.dart';
import 'package:gio_game_admin/utils/colours.dart';
import 'package:gio_game_admin/widgets/textLabel.dart';
import 'package:menu_button/menu_button.dart';
import 'package:mysql_utils/mysql_utils.dart';

import '../../../utils/sql_data.dart';

class GameNameDropDownBtn extends StatefulWidget {
  Color? color;

  TextEditingController controller;
  String value;
  double size;
  TextOverflow overflow;
  FontWeight fontWeight;
  GameNameDropDownBtn(
      {Key? key,
      this.color = Colors.black,
      required this.controller,
      this.value = "Select Game",
      this.overflow = TextOverflow.ellipsis,
      this.fontWeight = FontWeight.w800,
      this.size = 0})
      : super(key: key);

  @override
  State<GameNameDropDownBtn> createState() => _GameNameDropDownBtnState();
}

String selectedVal = "";

final List<SelectedListItem> gameNames = [
  SelectedListItem(
    name: "Sample",
    value: "TYO",
    isSelected: false,
  ),
];

class _GameNameDropDownBtnState extends State<GameNameDropDownBtn> {
  @override
  Widget build(BuildContext context) {
    //controller.text = value;
    return Padding(
      padding: const EdgeInsets.fromLTRB(1, 10, 1, 10),
      child: FutureBuilder(
          future: getSQLData(),
          builder: (context, snapshot) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 10, 1, 5),
                  child: TextLabel(
                    text: widget.value,
                    color: AppColours.blueColour,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(10, 10, 1, 5),
                //   child: TextLabel(
                //     text: textController.gameNameController.text,
                //     color: AppColours.blueColour,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 1, 1, 1),
                  child: ButtonTheme(
                    minWidth: 200,
                    child: OutlinedButton(
                      onPressed: () async {
                        DropDownState(
                          DropDown(
                            bottomSheetTitle: const Text(
                              "Games",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                            submitButtonChild: const Text(
                              'Done',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            data: gameNames,
                            selectedItems: (List<dynamic> selectedList) {
                              List<String> list = [];
                              for (var item in selectedList) {
                                if (item is SelectedListItem) {
                                  list.add(item.name);
                                }
                              }
                              //showSnackBar(list.toString());
                              setState(() {
                                textController.gameNameController.text =
                                    list[0].toString();
                                // widget.value = list[0].toString();
                              });

                              // print(widget.controller.text);
                            },
                            enableMultipleSelection: false,
                          ),
                        ).showModal(context);
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(1, 13, 1, 13),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0)),
                          backgroundColor: AppColours.whiteColour,
                          textStyle:
                              const TextStyle(color: AppColours.btnTextColour)),
                      child: Row(
                        children: [
                          Text(
                            textController.gameNameController.text,
                            style:
                                const TextStyle(color: AppColours.blueColour),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  final Widget normalChildButton = SizedBox(
    width: 100,
    height: 50,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(child: Text(selectedVal, overflow: TextOverflow.ellipsis)),
          const SizedBox(
            width: 12,
            height: 17,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Icon(
                Icons.arrow_drop_down,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    ),
  );

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

      var query = await db.query('SELECT * from games;');

      gameNames.clear();
      textController.clearShop();
      for (int i = 0; i < query.numOfRows; i++) {
        //items.add(query.rows[i]['area_name']);
        gameNames.add(SelectedListItem(name: query.rows[i]['game_name']));
        //textController.addShopValue(query.rows[i]['area_name'], 0);
      }

      db.close();
      //print(row.rows[0]); //{game_id: 1, staff_id: 1012, qty: 2, amount: 350.0, score: 1}
      //print(row.rows[0]["staff_id"]); //1012 -> gives values
    } catch (e) {
      print(e);
    }
  }
}
