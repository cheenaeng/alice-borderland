import 'package:flutter/material.dart';
import 'views/home_page.dart';
import 'views/pre_game_host.dart';
import 'views/pre_game_players.dart';
import 'views/start_game.dart';
import 'views/holding_room.dart';
import 'views/win_game.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(
    MaterialApp(
      title: 'Borderlanders',
      theme: ThemeData(
        fontFamily: 'CourierPrime',
      ),
      navigatorKey: navigatorKey,
      routes: <String, WidgetBuilder>{'/win': ((context) => WinGame())},
      home: SafeArea(
        child: HomePage(),
      ),
    ),
  );
}
