import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:gio_game_admin/screens/login.dart';
import 'package:gio_game_admin/utils/colours.dart';
import 'package:gio_game_admin/widgets/textF.dart';
import 'package:gio_game_admin/widgets/textLabel.dart';

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

class _CreateDateState extends State<CreateDate> {
  String _selectedDate = "";
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
                  text: "${selectedDate.toLocal()}".split(' ')[0],
                  color: AppColours.blueColour,
                  fontWeight: FontWeight.w600,
                ),
                IconButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    icon: Icon(Icons.calendar_month_outlined))
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
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        // if (widget.value == "from") {
        //   textController.fromDate = picked as Rx<DateTime Function()>;
        // }
        // if (widget.value == "to") {
        //   textController.toDate = picked as Rx<DateTime Function()>;
        // }

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

  // Future<void> _showAlertDialog() async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         // <-- SEE HERE
  //         title: const Text('Cancel booking'),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               SizedBox(
  //                 width: 300,
  //                 height: 300,
  //                 child: SfDateRangePicker(
  //                     onSelectionChanged: _onSelectionChanged,
  //                     selectionMode: DateRangePickerSelectionMode.single),
  //               ),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('Cancel'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           TextButton(
  //             child: const Text('Select Date'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
