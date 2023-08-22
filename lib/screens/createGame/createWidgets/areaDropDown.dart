import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:gio_game_admin/model/shopAreas.dart';
import 'package:gio_game_admin/screens/login.dart';
import 'package:gio_game_admin/utils/colours.dart';
import 'package:gio_game_admin/widgets/textLabel.dart';

import '../../../utils/api_service.dart';

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
  void initState() {
    super.initState();
    getSQLData();
  }

  @override
  Widget build(BuildContext context) {
    //controller.text = value;
    return Padding(
      padding: const EdgeInsets.fromLTRB(1, 10, 1, 10),
      child: Row(
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
                          //showSnackBar(list.toString());
                          setState(() {
                            widget.controller.text = list[0].toString();
                            widget.value = list[0].toString();
                          });

                          // print(widget.controller.text);
                        },
                        enableMultipleSelection: false,
                      ),
                    ).showModal(context);
                  },
                  icon: const Icon(Icons.arrow_drop_down))
            ]),
          )
        ],
      ),
    );
  }

  Future<void> getSQLData() async {
    try {
      List<ShopAreas> shopAreasList = [];

      shopAreasList = await ApiService().getShopAreasData();
      Future.delayed(const Duration(seconds: 1))
          .then((value) => setState(() {}));

      items.clear();
      textController.clearShop();
      for (int i = 0; i < shopAreasList.length; i++) {
        //items.add(query.rows[i]['area_name']);
        items.add(SelectedListItem(name: shopAreasList[i].areaName));
        //textController.addShopValue(query.rows[i]['area_name'], 0);
      }
    } catch (e) {
      print(e);
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
