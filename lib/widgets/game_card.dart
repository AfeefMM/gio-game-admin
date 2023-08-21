// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/colours.dart';
import '../utils/dimensions.dart';
import 'textLabel.dart';

class GameCard extends StatefulWidget {
  String title;
  String toDate;
  String fromDate;
  String score;

  GameCard({
    Key? key,
    required this.title,
    required this.toDate,
    required this.fromDate,
    required this.score,
  }) : super(key: key);

  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  @override
  Widget build(BuildContext context) {
    //controller.text = value;
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: Dimensions.width375,
              child: Card(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: AppColours.whiteColour,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(1, 15, 1, 5),
                                child: TextLabel(
                                  text: widget.title.toUpperCase(),
                                  size: 20,
                                  color: AppColours.blueColour,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 1, 15),
                            child: Row(
                              children: [
                                TextLabel(text: widget.fromDate, size: 16),
                                const Text(" - "),
                                TextLabel(text: widget.toDate, size: 16),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
