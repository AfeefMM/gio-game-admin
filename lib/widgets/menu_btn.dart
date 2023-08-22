import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gio_game_admin/screens/createGame/create_game_1.dart';
import 'package:gio_game_admin/screens/view_games.dart';
import 'package:gio_game_admin/widgets/textLabel.dart';


import '../controllers/text_controller.dart';

import '../utils/colours.dart';

class MenuBtn extends StatefulWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  FontWeight fontWeight;
  String value;
  String type;
  MenuBtn(
      {Key? key,
      this.color = AppColours.blueColour,
      required this.text,
      required this.type,
      this.value = "",
      this.overflow = TextOverflow.ellipsis,
      this.fontWeight = FontWeight.w800,
      this.size = 0})
      : super(key: key);

  @override
  State<MenuBtn> createState() => _MenuBtnState();
}

class _MenuBtnState extends State<MenuBtn> {
  final textController = Get.put(TextController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(1, 5, 1, 10),
        child: ButtonTheme(
          minWidth: 200,
          child: Material(
            elevation: 10,
            shadowColor: Colors.black,
            borderRadius: BorderRadius.circular(15),
            child: SizedBox(
              width: 225,
              height: 75,
              child: OutlinedButton(
                onPressed: () {
                  if (widget.type == "view") {
                    Get.to(() => ViewGamesPage());
                  }
                  if (widget.type == "create") {
                    Get.to(() => CreateGamePageStep());
                  }
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(1, 13, 1, 13),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    backgroundColor: AppColours.whiteColour,
                    textStyle:
                        const TextStyle(color: AppColours.btnTextColour)),
                child: TextLabel(
                  color: AppColours.blueColour,
                  fontWeight: FontWeight.bold,
                  text: widget.text,
                  size: 18,
                ),
              ),
            ),
          ),
        ));
  }
}
