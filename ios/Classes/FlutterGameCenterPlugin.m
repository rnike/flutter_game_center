#import "FlutterGameCenterPlugin.h"
#import <flutter_game_center/flutter_game_center-Swift.h>

@implementation FlutterGameCenterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterGameCenterPlugin registerWithRegistrar:registrar];
}
@end
