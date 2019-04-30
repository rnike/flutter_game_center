import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_game_center/flutter_game_center.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_game_center');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FlutterGameCenter.platformVersion, '42');
  });
}
