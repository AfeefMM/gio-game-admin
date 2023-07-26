import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gio_game_admin/screens/reviewGame/review_game.dart';

import 'package:mysql_utils/mysql_utils.dart';

import '../controllers/text_controller.dart';

import '../utils/colours.dart';
import '../utils/sql_data.dart';
import '../widgets/game_card.dart';
import '../widgets/textLabel.dart';
import 'login.dart';

class ViewGamesPage extends StatefulWidget {
  @override
  State<ViewGamesPage> createState() => _ViewGamesPageState();
}

final textController = Get.put(TextController());
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
      var db = MysqlUtils(
          settings: {
            'host': SQLData.ip,
            'port': SQLData.port,
            'user': SQLData.username,
            'password': SQLData.password,
            'db': SQLData.databaseName,
            'maxConnections': 10,
            'secure': true,
            'prefix': 'prefix_',
            'pool': true,
            'collation': 'utf8mb4_general_ci',
            'sqlEscape': true,
          },
          errorLog: (error) {
            print(error);
          },
          sqlLog: (sql) {
            print(sql);
          },
          connectInit: (db1) async {
            print('whenComplete');
          });

      // var row = await db.query('SELECT * from result_file');
      // numOfGames = row.numOfRows; //number of games

      // for (int i = 0; i < numOfGames; i++) {
      //   amounts.add(row.rows[i]['amount']);
      //   qtys.add(row.rows[i]['qty']);
      //   gameScores.add(row.rows[i]['score'].toString());
      //   gameIDs.add(row.rows[i]['game_id']);
      //   int gameID = gameIDs[i];
      //   // var query = await db.query(
      //   //     "SELECT * from game_file where game_id =" + gameID.toString());

      gameNames = [];
      gameIDs = [];
      gameFromDates = [];
      gameToDates = [];

      gameVal = [];
      numOfGames = 0;

      var query = await db.query('select * from game_file');
      numOfGames = query.numOfRows;

      // gameNames.add(query.rows[0]['game_name']);
      // gameIDs.add(query.rows[0]['game_id']);
      // gameFromDates.add(query.rows[0]['from_date']);
      // gameToDates.add(query.rows[0]['to_date']);
      // gameVal.add(query.rows[0]['game_value']);

      for (int j = 0; j < query.numOfRows; j++) {
        // if (query.rows[j]['game_id'] == gameID) {
        bool nameExists = false;
        for (int i = 0; i < gameNames.length; i++) {
          if (gameNames[i] == query.rows[j]['game_name'] &&
              gameFromDates[i] == query.rows[j]['from_date'] &&
              gameToDates[i] == query.rows[j]['to_date']) {
            nameExists = true;
          }
        }
        if (!nameExists) {
          gameNames.add(query.rows[j]['game_name']);
          gameIDs.add(query.rows[j]['game_id']);
          gameFromDates.add(query.rows[j]['from_date']);
          gameToDates.add(query.rows[j]['to_date']);
          gameVal.add(query.rows[j]['game_value']);
        }

        // }
      }

      // }
      db.close();
      //print(row.rows[0]); //{game_id: 1, staff_id: 1012, qty: 2, amount: 350.0, score: 1}
      //print(row.rows[0]["staff_id"]); //1012 -> gives values
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
      body: FutureBuilder(
        future: getSQLData(),
        builder: (context, snapshot) {
          return Container(
            child: ListView.builder(
                itemCount: gameNames.length,
                itemBuilder: (context, index) {
                  String title = gameNames[index].toString();

                  String toDate = gameToDates[index].toString();

                  String fromDate = gameFromDates[index].toString();
                  // var gameID = int.parse(gameIDs[index]);
                  print("game name: " + index.toString() + title);
                  // String score = gameScores[index].toString();

                  return GestureDetector(
                    onTap: () {
                      // print("tapped score: " + score); //this works well
                      //pass the score and base value of game
                      // currGameID = gameIDs[index]; //get game ID
                      Get.to(
                          () => ReviewPage(
                                title: title,
                                fromDate: fromDate,
                                toDate: toDate,
                              ),
                          arguments: [staffName]);
                    },
                    child: GameCard(
                      title: title,
                      toDate: "${toDate}".split(' ')[0],
                      fromDate: "${fromDate}".split(' ')[0],
                      score: "0",
                      basVal: gameVal[index],
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}
