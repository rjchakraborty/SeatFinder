import 'package:flutter/material.dart';
import 'package:seat/screens/home.dart';
import 'package:seat/utils/AppConstants.dart';
import 'package:seat/utils/CustomRouter.dart';
import 'package:seat/utils/HexColor.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'SeatFinder',
    onGenerateRoute: CustomRouter.generateRoute,
    initialRoute: Home.routeName,
    routes: CustomRouter.getRoutes(),
    theme: ThemeData(
        primarySwatch: HexColor.getMaterialColor(PRIMARY_COLOR_HEX),
        primaryColor: HexColor.getColor(PRIMARY_COLOR_HEX),
        primaryColorDark: HexColor.getColor(PRIMARY_COLOR_HEX),
        primaryColorLight: HexColor.getColor(PRIMARY_LIGHT_COLOR_HEX),
        appBarTheme: AppBarTheme(
          backgroundColor: HexColor.getColor('ff5955'),
          iconTheme: const IconThemeData(color: Colors.white), // set backbutton color here which will reflect in all screens.
        ),
        fontFamily: 'GorditaRegular'),
    home: Home(),
  ));
}
