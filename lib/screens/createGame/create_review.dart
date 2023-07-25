// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gio_game_admin/utils/dimensions.dart';
import 'package:mysql_utils/mysql_utils.dart';

import 'package:gio_game_admin/screens/reviewGame/review_tLabel.dart';
import 'package:gio_game_admin/screens/view_games.dart';
import 'package:gio_game_admin/widgets/menu_btn.dart';

import '../../controllers/text_controller.dart';
import '../../utils/colours.dart';
import '../../utils/sql_data.dart';
import '../../widgets/textLabel.dart';
import '../login.dart';

class CreateReviewPage extends StatefulWidget {
  @override
  State<CreateReviewPage> createState() => _CreateReviewPageState();

  CreateReviewPage({
    Key? key,
  }) : super(key: key);
}

final textController = Get.put(TextController());

//final gameData = <List<String>>[[]];

late var gameName, fromDate, toDate, gameArea, listOfShops, listOfVals;

class _CreateReviewPageState extends State<CreateReviewPage> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  String capitalizeFirstLetter(String input) {
    if (input == null || input.isEmpty) {
      return '';
    }
    return input[0].toUpperCase() + input.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    print(textController.shops.value.length);
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
            IconButton(
                onPressed: () {
                  //create dropdown menu for logging out
                  Get.off(() => LoginPage());
                },
                icon: const Icon(Icons.logout_outlined))
          ],
        ),
        backgroundColor: AppColours.mainColor,
        body: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
            ReviewText(
                text: textController.gameNameController.text,
                textTitle: "Game Name: "),
            ReviewText(
                text: textController.gameFromDateController.text,
                textTitle: "From Date: "),
            ReviewText(
                text: textController.gameToDateController.text,
                textTitle: "To Date: "),
            ReviewText(
                text: textController.shopAreaController.text,
                textTitle: "Area: "),
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 300,
                    width: Dimensions.screenWidth - 50,
                    child: GridView.count(
                      // Create a grid with 2 columns. If you change the scrollDirection to
                      // horizontal, this produces 2 rows.
                      crossAxisCount: 2,
                      // Generate 100 widgets that display their index in the List.
                      children: List.generate(textController.shops.value.length,
                          (index) {
                        String? name = textController.shops.value
                            .elementAt(index)
                            .shopName;
                        print("name: " + name.toString());
                        int? value = textController.shops.value
                            .elementAt(index)
                            .shopValue;
                        return Column(
                          children: [
                            // Text(code.customerName)
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
                              child: Row(
                                children: [
                                  TextLabel(
                                    text: name!,
                                    color: AppColours.blueColour,
                                    size: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  const Text(" - "),
                                  TextLabel(
                                    text: value!.toString(),
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
        )));
  }
}
