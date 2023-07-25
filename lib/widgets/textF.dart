import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gio_game_admin/model/shop_model.dart';
import 'package:gio_game_admin/screens/login.dart';
import '../controllers/text_controller.dart';
import '../utils/colours.dart';
import '../utils/dimensions.dart';

class TextF extends StatelessWidget {
  Color? color;
  final String text;
  var controller;
  String value;
  int index;
  double size;
  TextOverflow overflow;
  FontWeight fontWeight;
  TextF(
      {Key? key,
      this.color = Colors.black,
      required this.text,
      required this.controller,
      this.value = "",
      this.index = 0,
      this.overflow = TextOverflow.ellipsis,
      this.fontWeight = FontWeight.w800,
      this.size = 343})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textController = Get.put(TextController());
    bool pass = false;
    if (text == "Password") {
      pass = true;
    }
    //controller.text = value;
    return Padding(
      padding: const EdgeInsets.fromLTRB(1, 5, 1, 20),
      child: SizedBox(
        width: size,
        child: TextField(
          onEditingComplete: () {
            if (controller != null) {
              if (text == "0") {
                textController.addShopValue(value, int.parse(controller.text));

                print(textController.shops.value.elementAt(0).shopName);
                print(textController.shops.value.elementAt(0).shopValue);
              }
            }
          },
          obscureText: pass,
          controller: controller,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontFamily: 'WorkSans',
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColours.whiteColour,
            enabledBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(color: AppColours.blueColour, width: 1.5)),
            hintText: text,
          ),
        ),
      ),
    );
  }
}
