# Flutter Game Center Plugin
The reason I made this is because I can't find any plugin which I can use in my dart version.

Thanks for [this](https://github.com/ext452/game_center), that I can make it faster, appreciate it.

## CAUTION

Only avaliable on iOS.

## Now avaliable methods
  - authenticate
  - isAuthenticated
  - showLeadBoard
  - loadScore
  - submitScore
## Install
pubspec.yaml
```yaml
dependencies:
  flutter:
    sdk: flutter
  ....
  
  # Add this 
  flutter_game_center:
    git: https://github.com/yum650350/flutter_game_center.git
```
## Useage
```dart
import 'package:flutter_game_center/flutter_game_center.dart';

//yore leaderboard id
const LEADERBOARD_ID_IOS = 'your_leaderboard_id';

//authenticate
await FlutterGameCenter.authenticate();

//check authenticate
bool isSignIn = await FlutterGameCenter.isAuthenticated();

//show leaderboard
await FlutterGameCenter.showLeadBoard(LEADERBOARD_ID_IOS);

//load score
var timeScope = TimeScope.ALLTIME;
int score = await FlutterGameCenter.loadScore(LEADERBOARD_ID_IOS,timeScope);

//submit score
int score = 100;
bool success = await FlutterGameCenter.submitScore(LEADERBOARD_ID_IOS,score);

```

## TO DO
  - game save
  - achievement
