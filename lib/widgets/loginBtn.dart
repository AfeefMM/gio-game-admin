import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../controllers/text_controller.dart';

import '../model/userControl.dart';
import '../screens/menu.dart';
import '../utils/api_service.dart';
import '../utils/colours.dart';

class LoginBtn extends StatefulWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  FontWeight fontWeight;
  String value;
  LoginBtn(
      {Key? key,
      this.color = AppColours.blueColour,
      required this.text,
      this.value = "",
      this.overflow = TextOverflow.ellipsis,
      this.fontWeight = FontWeight.w800,
      this.size = 0})
      : super(key: key);

  @override
  State<LoginBtn> createState() => _LoginBtnState();
}

class _LoginBtnState extends State<LoginBtn> {
  final textController = Get.put(TextController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(1, 5, 1, 10),
        child: ButtonTheme(
          minWidth: 200,
          child: OutlinedButton(
            onPressed: () async {
              try {
                late List<ControlFile> _userModel = [];

                _userModel = await ApiService().getUsers();
                Future.delayed(const Duration(seconds: 1))
                    .then((value) => setState(() {})); //change seconds

                String staffName = '';

                bool flag = false;
                bool userExist = false;
                for (int i = 0; i < _userModel.length; i++) {
                  var id = textController.staffIDController.text;
                  var pass = textController.staffPassController.text;
                  var sqlID = _userModel[i].staffId.toString();
                  var sqlPass = _userModel[i].passwword;
                  // print(sqlID!.toString() + " and " + sqlPass!);
                  if (id == sqlID && pass == sqlPass) {
                    staffName = _userModel[i].name!;
                    flag = true;
                  }
                  if (id == sqlID) {
                    userExist = true;
                  }
                }

                if (flag) {
                  textController.staffPassController.clear();
                  textController.staffNameController.text = staffName;
                  Get.to(() => MenuPage(), arguments: staffName);
                } else if (userExist) {
                  _showDialog("Wrong password");
                } else {
                  _showDialog("User does not exist");
                }
              } catch (e) {
                print(e);
              }
            },
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(1, 13, 1, 13),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0)),
                backgroundColor: AppColours.blueColour,
                textStyle: const TextStyle(color: AppColours.btnTextColour)),
            child: Text(
              widget.text,
              style: const TextStyle(color: AppColours.btnTextColour),
            ),
          ),
        ));
  }

  bool _isDialogShowing = false;

  void _showDialog(String text) {
    _isDialogShowing = true; // set it `true` since dialog is being displayed
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(1, 13, 1, 13),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0)),
                  backgroundColor: AppColours.blueColour,
                  textStyle: const TextStyle(color: AppColours.btnTextColour)),
              child: const Text(
                "Close",
                style: TextStyle(
                    color: AppColours.btnTextColour,
                    fontWeight: FontWeight.w500),
              ),
              onPressed: () {
                _isDialogShowing =
                    false; // set it `false` since dialog is closed
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
