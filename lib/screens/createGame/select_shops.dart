// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gio_game_admin/widgets/textF.dart';
import 'package:mysql_utils/mysql_utils.dart';

import 'package:gio_game_admin/screens/createGame/createWidgets/textCreateField.dart';
import 'package:gio_game_admin/screens/reviewGame/review_game.dart';

import '../../controllers/text_controller.dart';
import '../../utils/colours.dart';
import '../../utils/sql_data.dart';
import '../../widgets/textLabel.dart';
import 'createWidgets/areaDropDown.dart';
import 'createWidgets/createDateWid.dart';

class SelectShopsPage extends StatefulWidget {
  @override
  State<SelectShopsPage> createState() => _SelectShopsPageState();
  String areaName;
  SelectShopsPage({
    Key? key,
    required this.areaName,
  }) : super(key: key);
}

final textController = Get.put(TextController());
List<TextEditingController> _shopValController = [];

var shopList = [];

class _SelectShopsPageState extends State<SelectShopsPage> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
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
                        text: "Select Shops",
                        size: 24,
                        color: AppColours.blueColour,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: shopList.length,
                  itemBuilder: (context, index) {
                    _shopValController.add(TextEditingController());
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(1, 20, 1, 20),
                          child: TextLabel(
                            text: shopList[index],
                            color: AppColours.blueColour,
                          ),
                        ),
                        TextF(
                            text: "shopVal",
                            value: shopList[index],
                            controller: _shopValController[index]),
                      ],
                    );
                  },
                )),
                //button
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
                            },
                            style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.fromLTRB(1, 13, 1, 13),
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
            );
          }),
    );
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

      var query = await db.query('SELECT * from shops;');

      shopList.clear();

      for (int i = 0; i < query.numOfRows; i++) {
        if (query.rows[i]['shop_area'] == widget.areaName) {
          shopList.add(query.rows[i]['shop_id']);
        }
      }

      db.close();
      //print(row.rows[0]); //{game_id: 1, staff_id: 1012, qty: 2, amount: 350.0, score: 1}
      //print(row.rows[0]["staff_id"]); //1012 -> gives values
    } catch (e) {
      print(e);
    }
  }
}
