import 'package:flutter/material.dart';

class SQLData {
  static const String ip = "10.7.84.124";
  static const port = 3306;
  static const String databaseName = "gio_game";
  // static const String username = "root";
  // static const String password = "Alphabeta01";
  static const String username = "afeef";
  static const String password = "apple";

  static String priceColourQuery(String style, String colour) {
    return "Select top 1 pcsprc from TIGERPOS.dbo.mfprch where pccolr like '${colour}' and pcstyl like '${style}%' order by pctxdt desc; ";
  }
}
