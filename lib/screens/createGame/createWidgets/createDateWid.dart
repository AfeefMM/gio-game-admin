import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:gio_game_admin/screens/login.dart';
import 'package:gio_game_admin/utils/colours.dart';
import 'package:gio_game_admin/widgets/textF.dart';
import 'package:gio_game_admin/widgets/textLabel.dart';

import '../../../controllers/text_controller.dart';

class CreateDate extends StatefulWidget {
  Color? color;
  final String text;
  TextEditingController controller;
  String value;
  double size;
  TextOverflow overflow;
  FontWeight fontWeight;
  CreateDate(
      {Key? key,
      this.color = Colors.black,
      required this.text,
      required this.controller,
      required this.value,
      this.overflow = TextOverflow.ellipsis,
      this.fontWeight = FontWeight.w800,
      this.size = 0})
      : super(key: key);

  @override
  State<CreateDate> createState() => _CreateDateState();
}

final textController = Get.put(TextController());

class _CreateDateState extends State<CreateDate> {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    //controller.text = value;
    return Padding(
      padding: const EdgeInsets.fromLTRB(1, 10, 1, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 10, 1, 5),
                child: TextLabel(
                  text: widget.text,
                  color: AppColours.blueColour,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(1, 10, 10, 5),
            child: Row(
              children: [
                //make datepicker popup
                TextLabel(
                  text: textController.isFromSelected
                      ? "${selectedDate.toLocal()}".split(' ')[0]
                      : "",
                  color: AppColours.blueColour,
                  fontWeight: FontWeight.w600,
                ),
                IconButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    icon: Icon(Icons.calendar_month_outlined)),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: textController.isFromSelected
          ? textController.fromDate
          : selectedDate, // Refer step 1
      firstDate: textController.isFromSelected
          ? textController.fromDate
          : DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;

        // print("selected date: " + selectedDate.toString());selected date: 2023-07-26 00:00:00.000
        if (widget.value == 'from') {
          textController.fromDate = selectedDate;
          textController.isFromSelected = true;
        }
        if (widget.value == 'to') {
          textController.toDate = selectedDate;
          textController.isToSelected = true;
        }
        widget.controller.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }
  // void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
  //   setState(() {
  //     if (args.value is DateTime) {
  //       _selectedDate = args.value.toString();
  //     }
  //   });
  // }

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
                "Close",
                style: TextStyle(color: AppColours.btnTextColour),
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
