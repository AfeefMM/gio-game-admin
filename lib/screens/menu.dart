import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gio_game_admin/utils/dimensions.dart';
import 'package:gio_game_admin/widgets/menu_btn.dart';

import '../controllers/text_controller.dart';
import '../utils/colours.dart';
import '../widgets/textLabel.dart';
import 'login.dart';

class MenuPage extends StatefulWidget {
  @override
  State<MenuPage> createState() => _MenuPageState();
}

final textController = Get.put(TextController());

var staffName = Get.arguments;

class _MenuPageState extends State<MenuPage> {
  @override
  void initState() {
    // TODO: implement initState
    textController.isNumber = false;
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
    //getSQLData();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColours.blueColour,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(30, 1, 1, 1),
            child: TextLabel(
              text: "Welcome ${capitalizeFirstLetter(staffName)}",
              color: AppColours.whiteColour,
              fontWeight: FontWeight.w500,
              size: 14,
            ),
          ),
          leadingWidth: Dimensions.width300,
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(1, 40, 1, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextLabel(
                    text: "Menu",
                    size: 24,
                    color: AppColours.blueColour,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(1, 20, 1, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MenuBtn(
                    text: "Create Game",
                    type: "create",
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(1, 20, 1, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MenuBtn(
                    text: "View Game",
                    type: "view",
                  ),
                ],
              ),
            ),
            const Spacer()
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     TextLabel(
            //       text: "data",
            //       color: AppColours.mainColor,
            //     ),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     TextLabel(
            //       text: "data",
            //       color: AppColours.mainColor,
            //     ),
            //   ],
            // ),
          ],
        ));
  }
}
