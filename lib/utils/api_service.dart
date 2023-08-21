import 'dart:developer';

import 'package:gio_game_admin/model/userControl.dart';
import 'package:gio_game_admin/utils/apis.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<ControlFile>> getUsers() async {
    try {
      var url = Uri.parse(APIVals.baseUrl + APIVals.getAllUsers);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<ControlFile> _model = userModelFromJson(response.body);
        // List<ControlFile> _model = Contro(response.body);
        print("response: ");
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return [];
  }
}
