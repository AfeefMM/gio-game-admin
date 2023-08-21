import 'dart:developer';

import 'package:gio_game_admin/model/gameFile.dart';
import 'package:gio_game_admin/model/userControl.dart';
import 'package:gio_game_admin/utils/apis.dart';
import 'package:http/http.dart' as http;

class ApiService {
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
