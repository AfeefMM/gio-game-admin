import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/text_controller.dart';
import '../utils/colours.dart';
import '../widgets/loginBtn.dart';
import '../widgets/textF.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

final textController = Get.put(TextController());

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: AppColours.mainColor,
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset("assets/Giordano-logo 1.png")],
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextF(
                    text: "Staff ID",
                    controller: textController.staffIDController),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextF(
                    text: "Password",
                    controller: textController.staffPassController),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [LoginBtn(text: "Login")],
            )
          ],
        ),
        Row(
          //dummy row for sizing
          children: const [
            Text(
              "data",
              style: TextStyle(color: AppColours.mainColor),
            )
          ],
        )
      ]),
    );
  }
}
