// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gio_game_admin/utils/dimensions.dart';

import 'package:gio_game_admin/screens/reviewGame/review_tLabel.dart';

import '../../controllers/text_controller.dart';
import '../../utils/colours.dart';
import '../../widgets/textLabel.dart';
import 'createWidgets/createGameBtn.dart';
import 'create_game_1.dart';

class CreateReviewPage extends StatefulWidget {
  @override
  State<CreateReviewPage> createState() => _CreateReviewPageState();

  CreateReviewPage({
    Key? key,
  }) : super(key: key);
}

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
    print(textController.shopCount);
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
        body: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(1, 30, 1, 30),
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
                    height: Dimensions.screenHeight / 3,
                    width: Dimensions.screenWidth - 50,
                    child: GridView.count(
                      // Create a grid with 2 columns. If you change the scrollDirection to
                      // horizontal, this produces 2 rows.
                      crossAxisCount: 1,
                      childAspectRatio: (Dimensions.screenWidth / 2) /
                          (Dimensions.screenHeight / 24),
                      // Generate 100 widgets that display their index in the List.
                      children: List.generate(textController.shops.value.length,
                          (index) {
                        String? name = textController.shops.value
                            .elementAt(index)
                            .shopName;

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
            CreateGameBtn(
              text: 'Create',
            ),
          ],
        )));
  }
}
