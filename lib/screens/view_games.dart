import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gio_game_admin/screens/reviewGame/review_game.dart';

import '../controllers/text_controller.dart';

import '../model/gameFile.dart';
import '../utils/api_service.dart';
import '../utils/colours.dart';
import '../widgets/game_card.dart';
import 'login.dart';

class ViewGamesPage extends StatefulWidget {
  @override
  State<ViewGamesPage> createState() => _ViewGamesPageState();
}

final textController = Get.put(TextController());
List<GameFile> gamesList = [];

var gameNames = [];
var gameIDs = [];
var gameFromDates = [];
var gameToDates = [];
// var qtys = [];
// var amounts = [];
// var gameScores = [];
var gameVal = [];
var numOfGames = 0;
var staffName = Get.arguments;
var currGameID = 0;

class _ViewGamesPageState extends State<ViewGamesPage> {
  @override
  void initState() {
    // TODO: implement initState
    getSQLData();
    super.initState();
  }

  Future<void> getSQLData() async {
    try {
      gamesList = await ApiService().getGameFileData();
      Future.delayed(const Duration(seconds: 1))
          .then((value) => setState(() {}));

      gameNames = [];
      gameIDs = [];
      gameFromDates = [];
      gameToDates = [];

      gameVal = [];
      numOfGames = 0;

      numOfGames = gamesList.length;

      for (int j = 0; j < gamesList.length; j++) {
        // if (query.rows[j]['game_id'] == gameID) {
        bool nameExists = false;
        for (int i = 0; i < gameNames.length; i++) {
          if (gameNames[i] == gamesList[j].gameName &&
              gameFromDates[i] == gamesList[j].fromDate &&
              gameToDates[i] == gamesList[j].toDate) {
            nameExists = true;
          }
        }
        if (!nameExists) {
          gameNames.add(gamesList[j].gameName);
          gameIDs.add(gamesList[j].gameId);
          gameFromDates.add(gamesList[j].fromDate);
          gameToDates.add(gamesList[j].toDate);
          gameVal.add(gamesList[j].gameValue);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    //getSQLData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColours.blueColour,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                //create dropdown menu for logging out
                Get.off(() => LoginPage());
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
      backgroundColor: AppColours.mainColor,
      body: Container(
        child: ListView.builder(
            itemCount: gameNames.length,
            itemBuilder: (context, index) {
              String title = gameNames[index].toString();

              String toDate = gameToDates[index].toString();

              String fromDate = gameFromDates[index].toString();

              textController.fromDate = DateTime.parse(fromDate);
              textController.toDate = DateTime.parse(toDate);

              // var gameID = int.parse(gameIDs[index]);

              // String score = gameScores[index].toString();

              return GestureDetector(
                onTap: () {
                  // print("tapped score: " + score); //this works well
                  //pass the score and base value of game
                  // currGameID = gameIDs[index]; //get game ID

                  Get.to(
                      () => ReviewPage(
                            title: title,
                            fromDate: fromDate.toString(),
                            toDate: toDate.toString(),
                          ),
                      arguments: [staffName]);
                },
                child: GameCard(
                  title: title,
                  toDate: toDate.split('T')[0],
                  fromDate: fromDate.split('T')[0],
                  score: "0",
                ),
              );
            }),
      ),
    );
  }
}
