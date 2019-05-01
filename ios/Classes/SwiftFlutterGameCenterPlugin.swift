import Flutter
import UIKit
import GameKit

public class SwiftFlutterGameCenterPlugin: NSObject, GKGameCenterControllerDelegate, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_game_center", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterGameCenterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
  let AUTHENTICATE = "authenticate"
  let IS_AUTHENTICATED = "isAuthenticated"
  let SUBMITSCORE = "submitScore"
  let SHOWLEADERBOARD = "showLeaderboard"
  let LOADSCORE = "loadScore"
  
  
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
        case AUTHENTICATE:
            result(authenticate())
        case IS_AUTHENTICATED:
            result(GKLocalPlayer.localPlayer().isAuthenticated)
        case SUBMITSCORE:
            let args = call.arguments as? NSDictionary
            
            let leaderBoardId = args?.allKeys[0] as! String
            let score = args?.value(forKey: leaderBoardId) as! Int
            
            result(submitScore(leadBpardId: leaderBoardId, score: score))
        case SHOWLEADERBOARD:
            let leadBoardId = call.arguments as? String
            if leadBoardId != nil {
                result(showLeaderboard(leadBoardId: leadBoardId!))
            } else {
                result(false)
            }
        case LOADSCORE:
            let args = call.arguments as? NSDictionary
            let leaderBoardId = args?.allKeys[0] as! String
            let scope = args?.value(forKey: leaderBoardId) as! Int
            let tc:GKLeaderboardTimeScope = scope == 0 ? .allTime : scope == 1 ?.today : .week
            _ = loadScore(leadBoardId: leaderBoardId,timeScope:tc){
                (output) in
                result(output)
            }
        default:
            result("No such mathod")
    }  
  }
    func authenticate() -> Bool{
        let localPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {
            (view, error) in
            if error != nil {
                 
            } else if view != nil {
                UIApplication.shared.keyWindow?.rootViewController?.present(view!, animated: true, completion: nil)
            }
            else {
            
            }
        }
        return true
    }

    func submitScore(leadBpardId: String, score: Int) -> Bool {
        if GKLocalPlayer.localPlayer().isAuthenticated {
            let scoreReporter = GKScore(leaderboardIdentifier: leadBpardId)
            scoreReporter.value = Int64(score)
            let scoreArray: [GKScore] = [scoreReporter]
            GKScore.report(scoreArray, withCompletionHandler: nil)
            
            return true
        } else {
            return false
        }
    }
    func showLeaderboard(leadBoardId: String) -> Bool {
        
        if GKLocalPlayer.localPlayer().isAuthenticated {
            let gcVC = GKGameCenterViewController()
            
            gcVC.leaderboardIdentifier = leadBoardId
            gcVC.gameCenterDelegate = self
            gcVC.viewState = GKGameCenterViewControllerState.leaderboards
            
            UIApplication.shared.keyWindow?.rootViewController?.present(gcVC, animated: true, completion: nil)
            
            return true
        } else {
            return false
        }
        
        
    }
    func loadScore(leadBoardId: String,timeScope:GKLeaderboardTimeScope ,completion:@escaping (Int64) -> Void){
      let leaderboardRequest = GKLeaderboard()
      leaderboardRequest.timeScope = timeScope
      leaderboardRequest.identifier = leadBoardId
      leaderboardRequest.loadScores(completionHandler: { scores, error in
        
            var loadedScore = Int64()
          if error != nil {
              if let error = error {
                  print("\(error)")
              }
          } else if scores != nil {
              let localPlayerScore: GKScore? = leaderboardRequest.localPlayerScore
              if localPlayerScore == nil{
                loadedScore = 0
                print("no score");
              }else{

               loadedScore = localPlayerScore!.value
            print("load :\(loadedScore)");
              }
              
          }else{
            loadedScore = 0;
        }
        completion(loadedScore)
      })
           
    }

  public func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
