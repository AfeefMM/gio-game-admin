import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gio_game_admin/model/userControl.dart';

import '../controllers/text_controller.dart';
import '../utils/api_service.dart';
import '../utils/colours.dart';
import '../widgets/loginBtn.dart';
import '../widgets/textF.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

final textController = Get.put(TextController());

class _LoginPageState extends State<LoginPage> {
  late List<ControlFile> _userModel = [];
  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _userModel = await ApiService().getUsers();
    Future.delayed(const Duration(seconds: 3))
        .then((value) => setState(() {})); //change seconds
  }

  @override
  Widget build(BuildContext context) {
    print(_userModel[0].name.toString());
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
        const Row(
          //dummy row for sizing
          children: [
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
