import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gio_game_admin/utils/colours.dart';
import 'package:gio_game_admin/widgets/textF.dart';
import 'package:gio_game_admin/widgets/textLabel.dart';
import 'package:mysql_utils/mysql_utils.dart';

import '../../../utils/dimensions.dart';
import '../../../utils/sql_data.dart';

class AreaDropDownBtn extends StatefulWidget {
  Color? color;

  TextEditingController controller;
  String value;
  double size;
  TextOverflow overflow;
  FontWeight fontWeight;
  AreaDropDownBtn(
      {Key? key,
      this.color = Colors.black,
      required this.controller,
      this.value = "Select Area",
      this.overflow = TextOverflow.ellipsis,
      this.fontWeight = FontWeight.w800,
      this.size = 0})
      : super(key: key);

  @override
  State<AreaDropDownBtn> createState() => _AreaDropDownBtnState();
}

//String? selectedVal;
final List<SelectedListItem> items = [
  SelectedListItem(
    name: "Sample",
    value: "TYO",
    isSelected: false,
  ),
];

class _AreaDropDownBtnState extends State<AreaDropDownBtn> {
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
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // DropdownButton2(
                //   items: items
                //       .map((String item) => DropdownMenuItem<String>(
                //             value: item,
                //             child: Text(
                //               item,
                //               style: const TextStyle(
                //                 fontSize: 14,
                //               ),
                //             ),
                //           ))
                //       .toList(),
                //   value: selectedVal,
                //   hint: const Text("Select Area"),
                //   onChanged: (value) {
                //     setState(() {
                //       selectedVal = value!;
                //       widget.controller.text = selectedVal!;
                //     });
                //   },
                // ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(1, 10, 1, 10),
                  child: Row(children: [
                    IconButton(
                        onPressed: () {
                          DropDownState(
                            DropDown(
                              bottomSheetTitle: const Text(
                                "Areas",
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
                              data: items,
                              selectedItems: (List<dynamic> selectedList) {
                                List<String> list = [];
                                for (var item in selectedList) {
                                  if (item is SelectedListItem) {
                                    list.add(item.name);
                                  }
                                }
                                showSnackBar(list.toString());
                                setState(() {
                                  widget.controller.text = list[0].toString();
                                  widget.value = list[0].toString();
                                });

                                print(widget.controller.text);
                              },
                              enableMultipleSelection: false,
                            ),
                          ).showModal(context);
                        },
                        icon: const Icon(Icons.arrow_drop_down))
                  ]),
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

      var query = await db.query('SELECT * from shop_areas;');

      items.clear();
      for (int i = 0; i < query.numOfRows; i++) {
        //items.add(query.rows[i]['area_name']);
        items.add(SelectedListItem(name: query.rows[i]['area_name']));
      }

      db.close();
      //print(row.rows[0]); //{game_id: 1, staff_id: 1012, qty: 2, amount: 350.0, score: 1}
      //print(row.rows[0]["staff_id"]); //1012 -> gives values
    } catch (e) {
      print(e);
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
