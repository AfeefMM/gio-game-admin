import 'package:flutter/material.dart';

import '../utils/colours.dart';
import '../utils/dimensions.dart';

class TextLabel extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  FontWeight fontWeight;
  TextLabel(
      {Key? key,
      this.color = Colors.black,
      required this.text,
      this.overflow = TextOverflow.ellipsis,
      this.fontWeight = FontWeight.w500,
      this.size = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 3,
      overflow: overflow,
      style: TextStyle(
          color: color,
          fontSize: size == 0 ? Dimensions.font20 : size,
          fontWeight: fontWeight,
          fontFamily: 'WorkSans'
          //fontFamily: 'Roboto', add font family to assets folder then to pubsec.yaml
          ),
    );
  }
}
