// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gio_game_admin/screens/createGame/create_review.dart';
import 'package:gio_game_admin/widgets/textF.dart';

import '../../model/shops.dart';
import '../../utils/api_service.dart';
import '../../utils/colours.dart';
import '../../widgets/textLabel.dart';
import 'create_game_1.dart';

class SelectShopsPage extends StatefulWidget {
  @override
  State<SelectShopsPage> createState() => _SelectShopsPageState();
  String areaName;
  SelectShopsPage({
    Key? key,
    required this.areaName,
  }) : super(key: key);
}

List<TextEditingController> _shopValController = [];

var shopList = [];

class _SelectShopsPageState extends State<SelectShopsPage> {
  @override
  void initState() {
    // TODO: implement initState
    textController.isNumber = true;

    getSQLData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("building select shop page");
    //getSQLData();
    _shopValController.clear(); //clears textcontroller for the shop values
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
                  textController.clearVals();
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
              padding: const EdgeInsets.fromLTRB(20, 40, 1, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextLabel(
                    text: "Select Shops",
                    size: 24,
                    color: AppColours.blueColour,
                    fontWeight: FontWeight.w600,
                  ),
                  //button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(1, 5, 30, 1),
                          child: ButtonTheme(
                            minWidth: 300,
                            child: OutlinedButton(
                              onPressed: () async {
                                //onto next page
                                print(_shopValController.length.toString());
                                Get.to(() => CreateReviewPage());
                                textController.isNumber = false;
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
                                  "Review",
                                  style: TextStyle(
                                      color: AppColours.btnTextColour,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: shopList.length,
              itemBuilder: (context, index) {
                _shopValController.add(TextEditingController());
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(1, 1, 1, 20),
                      child: TextLabel(
                        text: shopList[index],
                        color: AppColours.blueColour,
                      ),
                    ),
                    TextF(
                        text: "0",
                        value: shopList[index],
                        controller: _shopValController[index]),
                  ],
                );
              },
            )),
          ],
        ));
  }

  Future<void> getSQLData() async {
    try {
      List<Shops> listOfShops = [];

      listOfShops = await ApiService().getShopsData();
      Future.delayed(const Duration(seconds: 1))
          .then((value) => setState(() {}));

      shopList.clear();

      for (int i = 0; i < listOfShops.length; i++) {
        if (listOfShops[i].shopArea == widget.areaName) {
          shopList.add(listOfShops[i].shopId);
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
