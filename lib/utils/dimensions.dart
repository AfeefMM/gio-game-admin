import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double pageViewContainer = screenHeight /
      3.84; //factor = 844/220 = 3.84 - this for the food page card image
  static double pageView = screenHeight /
      2.64; //factor = 844/320 - this for the food page card image
  static double pageViewTextContainer =
      screenHeight / 7.03; //factor = 3.84 - this for the food page card text

  static double height10 = screenHeight / 84.4; //844/10
  static double height15 = screenHeight / 56.27; //844/15
  static double height20 = screenHeight / 42.2; //844/20
  static double height30 = screenHeight / 28.13; //844/30
  static double height45 = screenHeight / 18.76; //844/45
  static double heightDropDown = screenHeight / 1.68; //844/500
  static double heightImg = screenHeight / 2.91; //844/290
  static double height300 = screenHeight / 3.33; //1600/300
  static double height200 = screenHeight / 8; //1600/300

  static double widthImg = screenHeight / 1; //375/375

  static double width5 = screenWidth / 1.5; //844/10
  static double width10 = screenHeight / 84.4; //844/10
  static double width20 = screenHeight / 42.2; //844/20
  static double width15 = screenHeight / 56.27; //844/15
  static double width375 = screenWidth / 1.1; //844/300
  static double width300 = screenWidth / 2.813; //844/300
  static double width200 = screenWidth / 4.22; //844/300

  static double font20 = screenHeight / 42.2; //844/20

  static double radius15 = screenHeight / 56.27; //844/20
  static double radius20 = screenHeight / 42.2; //844/20
  static double radius30 = screenHeight / 28.13; //844/30

  static double iconSize24 = screenHeight / 35.17; //844/24
}
