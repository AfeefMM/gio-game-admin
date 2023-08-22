import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:gio_game_admin/model/gameFile.dart';
import 'package:gio_game_admin/model/games.dart';
import 'package:gio_game_admin/model/shopAreas.dart';
import 'package:gio_game_admin/model/shops.dart';
import 'package:gio_game_admin/model/userControl.dart';
import 'package:gio_game_admin/utils/apis.dart';
import 'package:http/http.dart' as http;

import '../screens/menu.dart';

class ApiService {
  Future<List<Shops>> getShopsData() async {
    try {
      var url = Uri.parse(APIVals.baseUrl + APIVals.getAllShops);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Shops> _model = shopsFromJson(response.body);

        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return [];
  }

  Future<List<ShopAreas>> getShopAreasData() async {
    try {
      var url = Uri.parse(APIVals.baseUrl + APIVals.getAllShopAreas);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<ShopAreas> _model = shopAreasFromJson(response.body);

        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return [];
  }

  Future<List<Games>> getGamesData() async {
    try {
      var url = Uri.parse(APIVals.baseUrl + APIVals.getAllGame);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Games> _model = gamesFromJson(response.body);

        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return [];
  }

  Future<List<GameFile>> getGameFileData() async {
    try {
      var url = Uri.parse(APIVals.baseUrl + APIVals.getAllGameFile);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<GameFile> _model = gameFileFromJson(response.body);

        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return [];
  }

  Future<List<GameFile>> createGameFile(textController, i) async {
    var jBody = jsonEncode({
      'gameName': textController.gameNameController.text,
      'fromDate': textController.gameFromDateController.text,
      'toDate': textController.gameToDateController.text,
      'storeCode': textController.shops.value.elementAt(i).shopName,
      'gameValue': textController.shops.value.elementAt(i).shopValue,
      'areaName': textController.shopAreaController.text,
    });
    print(jBody);
    final response = await http.post(
      Uri.parse(APIVals.baseUrl + APIVals.postGameFile),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jBody,
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.

      print("game created");

      return gameFileFromJson(response.body);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      print(response.body);
      throw Exception('Failed to create game.');
    }
  }

  void deleteGameFile(i) async {
    var jBody = jsonEncode({
      'gameId': i,
    });
    print(jBody);
    final delResponse = await http.delete(
        Uri.parse(APIVals.baseUrl + APIVals.deleteGameFile + i.toString()));
    // final response = await http.post(
    //   Uri.parse(APIVals.baseUrl + APIVals.deleteGameFile + i.toString()),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jBody,
    // );

    if (delResponse.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.

      print("game deleted");
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      print(delResponse.body);
      throw Exception('Failed to delete game.');
    }
  }

  Future<List<ControlFile>> getUsers() async {
    try {
      var url = Uri.parse(APIVals.baseUrl + APIVals.getAllUsers);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<ControlFile> _model = userModelFromJson(response.body);

        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return [];
  }
}
