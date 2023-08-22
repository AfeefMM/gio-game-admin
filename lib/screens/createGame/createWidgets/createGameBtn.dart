import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gio_game_admin/model/gameFile.dart';

import '../../../controllers/text_controller.dart';
import '../../../utils/api_service.dart';
import '../../../utils/colours.dart';
import '../../menu.dart';

class CreateGameBtn extends StatefulWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  FontWeight fontWeight;
  String value;
  CreateGameBtn(
      {Key? key,
      this.color = AppColours.blueColour,
      required this.text,
      this.value = "",
      this.overflow = TextOverflow.ellipsis,
      this.fontWeight = FontWeight.w800,
      this.size = 0})
      : super(key: key);

  @override
  State<CreateGameBtn> createState() => _CreateGameBtnState();
}

bool confirmState = false;

class _CreateGameBtnState extends State<CreateGameBtn> {
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
                List<GameFile> gamesList = [];

                gamesList = await ApiService().getGameFileData();
                Future.delayed(const Duration(seconds: 1))
                    .then((value) => setState(() {}));

                String fromDate = '';
                String toDate = '';
                String gameName = '';
                //shifted below from top of func
                bool gameExist = false;
                for (int i = 0; i < gamesList.length; i++) {
                  var name = textController.gameNameController.text;
                  var from = textController.gameFromDateController.text;
                  var to = textController.gameToDateController.text;

                  fromDate = gamesList[i].fromDate!.split('T')[0];
                  toDate = gamesList[i].toDate!.split('T')[0];
                  gameName = gamesList[i].gameName!;

                  if (gameName == name && fromDate == from && toDate == to) {
                    // staffName = row.rows[i]['name'];
                    gameExist = true;
                  }
                }

                // print(gameExist.toString() + " " + confirmState.toString());
                if (!gameExist) {
                  _showDialog("Confirm create game? ");

                  setState(() {
                    confirmState = false;
                  });

                  //Get.to(() => MenuPage());
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

  void insertGame() async {
    for (int i = 0; i < textController.shops.value.length; i++) {
      ApiService().createGameFile(textController, i);
      // print("game created");
      Get.to(() => MenuPage(),
          arguments: textController.staffNameController.text);
    }

    textController.staffPassController.clear();
  }

  bool compareDates() {
    var fromD = textController.fromDate;
    var toD = textController.toDate;
    if (fromD.compareTo(toD) < 0) {
      print("is lesser");
      return true;
    } else if (fromD.compareTo(toD) >= 0) {
      return false;
    }
    return false;
  }

  bool _isDialogShowing = false;

  void _showDialog(String text) {
    _isDialogShowing = true; // set it `true` since dialog is being displayed
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(text),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(1, 13, 1, 13),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0)),
                  backgroundColor: AppColours.blueColour,
                  textStyle: const TextStyle(color: AppColours.btnTextColour)),
              child: const Text(
                "Cancel",
                style: TextStyle(color: AppColours.btnTextColour),
              ),
              onPressed: () {
                _isDialogShowing =
                    false; // set it `false` since dialog is closed
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(1, 13, 1, 13),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0)),
                  backgroundColor: AppColours.blueColour,
                  textStyle: const TextStyle(color: AppColours.btnTextColour)),
              child: const Text(
                "Confirm",
                style: TextStyle(color: AppColours.btnTextColour),
              ),
              onPressed: () {
                insertGame();
                setState(() {
                  confirmState = true;
                });

                _isDialogShowing =
                    false; // set it `false` since dialog is closed
              },
            ),
          ],
        );
      },
    );
  }
}
