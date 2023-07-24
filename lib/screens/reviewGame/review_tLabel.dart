import 'package:flutter/material.dart';

import '../../utils/colours.dart';
import '../../widgets/textLabel.dart';

class ReviewText extends StatelessWidget {
  Color? color;
  final String text;
  final String textTitle;
  double size;
  TextOverflow overflow;
  FontWeight fontWeight;
  ReviewText(
      {Key? key,
      this.color = Colors.black,
      required this.text,
      required this.textTitle,
      this.overflow = TextOverflow.ellipsis,
      this.fontWeight = FontWeight.w500,
      this.size = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 1, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextLabel(
                text: textTitle,
                color: AppColours.blueColour,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(1, 5, 20, 5),
            child: Column(
              children: [
                TextLabel(
                  text: text,
                  color: AppColours.blueColour,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
