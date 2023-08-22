
class SQLData {
  static const String ip = "212.76.85.20"; //localhost
  static const port = 1433;
  static const String databaseName = "mobile_giordano_game"; //gio_game
  static const String username = "mobile_giordano_game"; //root //afeef
  static const String password = "Giogame2023#\$"; //Alphabeta01 //apple

  static String priceColourQuery(String style, String colour) {
    return "Select top 1 pcsprc from TIGERPOS.dbo.mfprch where pccolr like '${colour}' and pcstyl like '${style}%' order by pctxdt desc; ";
  }
}
