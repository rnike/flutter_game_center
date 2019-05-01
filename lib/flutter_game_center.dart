import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/services.dart';

typedef CallBacks = void Function(dynamic data);

enum TimeScope{ALLTIME,TODAY,WEEK}
class FlutterGameCenter {
  static const _AUTHENTICATE = "authenticate";
  static const _IS_AUTHENTICATED = "isAuthenticated";
  static const _SUBMITSCORE = "submitScore";
  static const _SHOWLEADERBOARD = "showLeaderboard";
  static const _LOADSCORE = "loadScore";
  static const MethodChannel _channel =
      const MethodChannel('flutter_game_center');

  static bool get check => Platform.isIOS;
  
  static Future<bool> authenticate() async {
    if (!check) return false;
    try {
      final result = await _channel.invokeMethod(_AUTHENTICATE);
      print(result);
      return result;
    } catch (e) {
      print(e);
    return false;
    }
  }

  static Future<bool> isAuthenticated() async {
    if (!check) return false;
    try {
      final result = await _channel.invokeMethod(_IS_AUTHENTICATED);
      return result;
    } catch (e) {
      print(e);
    }
    return false;
  }

  static Future<bool> submitScore(String leaderboardID,int score) async {
    if (!check) return false;
    try {
      final Map<String, int> data = {leaderboardID: score};
      final result = await _channel.invokeMethod(_SUBMITSCORE, data);
      return result;
    } catch (e) {
      print(e);
    }
    return false;
  }

  static Future<bool> showLeadBoard(String leaderBoardID) async {
    if (!check) return false;
    final bool result =
        await _channel.invokeMethod(_SHOWLEADERBOARD, leaderBoardID);

    if (result == true) {
      return true;
    } else {
      return Future.error(false);
    }
  }

  static Future<dynamic> loadScore(String leaderBoardID,TimeScope scope) async {
    if (!check) return null;
      final Map<String, int> data = {leaderBoardID: scope.index};
    final result = await _channel.invokeMethod(_LOADSCORE, data);

    return result;
  }
}
