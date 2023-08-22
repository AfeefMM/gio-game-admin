import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gio_game_admin/screens/login.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // FocusScopeNode currentFocus = FocusScope.of(context);

        // if (!currentFocus.hasPrimaryFocus) {
        //   currentFocus.unfocus();
        // }
        FocusScope.of(context).unfocus();
      },
      child: GetMaterialApp(
        title: 'Flutter Demo',
        home: LoginPage(),
      ),
    );
  }
}
