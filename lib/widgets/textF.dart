import 'package:flutter/material.dart';
import '../utils/colours.dart';
import '../utils/dimensions.dart';

class TextF extends StatelessWidget {
  Color? color;
  final String text;
  TextEditingController controller;
  String value;
  double size;
  TextOverflow overflow;
  FontWeight fontWeight;
  TextF(
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
    bool pass = false;
    if (text == "Password") {
      pass = true;
    }
    //controller.text = value;
    return Padding(
      padding: const EdgeInsets.fromLTRB(1, 5, 1, 20),
      child: SizedBox(
        width: 343,
        child: TextField(
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
