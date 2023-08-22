import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/text_controller.dart';
import '../utils/colours.dart';
import '../utils/dimensions.dart';

class TextF extends StatelessWidget {
  Color? color;
  final String text;
  var controller;
  double shopVal;
  String value;
  int index;
  double size;
  TextOverflow overflow;
  FontWeight fontWeight;
  TextF(
      {Key? key,
      this.color = Colors.black,
      this.shopVal = 0,
      required this.text,
      required this.controller,
      this.value = "",
      this.index = 0,
      this.overflow = TextOverflow.ellipsis,
      this.fontWeight = FontWeight.w800,
      this.size = 343})
      : super(key: key);

  FocusNode focusNode1 = FocusNode();

  @override
  Widget build(BuildContext context) {
    final textController = Get.put(TextController());
    bool pass = false;
    if (text == "Password") {
      pass = true;
    }
    //textController.focusNodes.add(FocusNode());
    focusNode1.addListener(
      () {
        bool shopNameExists = false;
        if (!focusNode1.hasFocus && text == "0") {
          for (int i = 0; i < textController.shops.value.length; i++) {
            if (textController.shops.value.elementAt(i).shopName == value) {
              shopNameExists = true;
            }
          }
          if (!shopNameExists) {
            textController.addShopValue(value, int.parse(controller.text));
          }

          print(textController.shops.value.elementAt(0).shopName);
          print(textController.shops.value.elementAt(0).shopValue);

          shopNameExists = false;
        }
      },
    );
    //controller.text = value;
    return Padding(
      padding: const EdgeInsets.fromLTRB(1, 5, 1, 20),
      child: SizedBox(
        width:
            textController.isNumber ? Dimensions.width200 : Dimensions.width375,
        child: TextField(
          focusNode: focusNode1,
          keyboardType: textController.isNumber
              ? TextInputType.number
              : TextInputType.name,
          inputFormatters: textController.isNumber
              ? <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                ]
              : [FilteringTextInputFormatter.singleLineFormatter],
          onEditingComplete: () {
            SystemChannels.textInput.invokeMethod('TextInput.hide');
            if (controller != null) {
              if (text == "0") {}
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
