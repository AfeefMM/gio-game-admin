import 'package:flutter/material.dart';
import 'package:gio_game_admin/utils/colours.dart';
import 'package:gio_game_admin/widgets/textF.dart';
import 'package:gio_game_admin/widgets/textLabel.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

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
      this.value = "",
      this.overflow = TextOverflow.ellipsis,
      this.fontWeight = FontWeight.w800,
      this.size = 0})
      : super(key: key);

  @override
  State<CreateDate> createState() => _CreateDateState();
}

class _CreateDateState extends State<CreateDate> {
  String _selectedDate = "";

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
                  text: widget.text,
                  color: AppColours.blueColour,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(1, 5, 1, 20),
            child: SizedBox(
              width: 343,
              child: Row(
                children: [
                  //make datepicker popup
                  // Container(
                  //   width: 300,
                  //   height: 300,
                  //   child: SfDateRangePicker(
                  //       onSelectionChanged: _onSelectionChanged,
                  //       selectionMode: DateRangePickerSelectionMode.single),
                  // ),
                  TextField(
                    controller: widget.controller,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'WorkSans',
                    ),
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: () {},
                        child: const Icon(Icons.calendar_month_outlined),
                      ),
                      filled: true,
                      fillColor: AppColours.whiteColour,
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColours.blueColour, width: 1.5)),
                      hintText: widget.text,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      }
    });
  }
}
