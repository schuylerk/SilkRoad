//
//  SceneDelegate.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/3/19.
//

import UIKit
import SwiftyJSON
import HandyJSON

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        guard UserDefaults.standard.value(forKey: "user") != nil else {
            let user = createUser()
            saveUser(user)
            window?.rootViewController = tabBar()
            return
        }
        window?.rootViewController = tabBar()
    }

}
