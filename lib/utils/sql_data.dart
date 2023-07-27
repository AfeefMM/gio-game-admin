import 'package:flutter/material.dart';

class SQLData {
  static const String ip = "localhost";
  static const port = 3306;
  static const String databaseName = "gio_game";
  static const String username = "root"; //afeef
  static const String password = "Alphabeta01"; //apple

  static String priceColourQuery(String style, String colour) {
    return "Select top 1 pcsprc from TIGERPOS.dbo.mfprch where pccolr like '${colour}' and pcstyl like '${style}%' order by pctxdt desc; ";
  }
}
