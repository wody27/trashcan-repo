//
//  SceneDelegate.swift
//  KakaoLinkAPITutorial
//
//  Created by 이재용 on 2021/03/18.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func parseQueryString(_ query: String?) -> Bool {
        guard let query = query else { return false }
        
        var dict = [String: String]()
        let queryComponents = query.components(separatedBy: "&")
        
        for theComponent in queryComponents {
            let elements = theComponent.components(separatedBy: "=")
            guard let key = elements[0].removingPercentEncoding else { continue }
            guard let val = elements[1].removingPercentEncoding else { continue }
            
            dict[key] = val
        }
        
        if dict.count == 0 { return false }
        
        NotificationCenter.default.post(name: .init("fromKakaoTalk"), object: dict)
        return true
    }
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    
        if let windowScene = scene as? UIWindowScene {
            
            UserDefaults.standard.set(true, forKey: "check")
            let window = UIWindow(windowScene: windowScene)
            guard let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "SecondViewController") as? SecondViewController else { return }
            window.rootViewController = vc
            self.window = window
            window.makeKeyAndVisible()
            
        }

        
        
        print("willConnectTo")
//        print(parseQueryString(connectionOptions.urlContexts.first?.url.query))
//        let window = UIWindow(frame: UIScreen.main.bounds)
//        guard let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "SecondViewController") as? SecondViewController else { return }
//        window.rootViewController = vc
//        self.window = window
//        window.makeKeyAndVisible()

        
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        print("sceneDidBecomeActive")
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        print("openURLContexts")
        print(parseQueryString(URLContexts.first?.url.query))
//        print("HI")
    }
}

