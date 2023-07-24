import 'package:flutter/material.dart';
import 'package:gio_game_admin/utils/colours.dart';
import 'package:gio_game_admin/widgets/textF.dart';
import 'package:gio_game_admin/widgets/textLabel.dart';

class CreateFields extends StatelessWidget {
  Color? color;
  final String text;
  TextEditingController controller;
  String value;
  double size;
  TextOverflow overflow;
  FontWeight fontWeight;
  CreateFields(
      {Key? key,
      this.color = Colors.black,
      required this.text,
      required this.controller,
      this.value = "",
      this.overflow = TextOverflow.ellipsis,
      this.fontWeight = FontWeight.w800,
      this.size = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //controller.text = value;
    return Padding(
      padding: const EdgeInsets.fromLTRB(1, 10, 1, 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 10, 1, 5),
                child: TextLabel(
                  text: text,
                  color: AppColours.blueColour,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          TextF(text: text, controller: controller)
        ],
      ),
    );
  }
}
