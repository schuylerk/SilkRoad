//
//  SceneDelegate.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/3/19.
//

import UIKit
import SwiftyJSON
import ESTabBarController_swift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var tabBarController: ESTabBarController!
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        tabBarController = tabBar { _, _, _ in }
        window?.rootViewController = tabBarController
        
        DispatchQueue.global().async {
            guard UserDefaults.standard.value(forKey: "schools") != nil else {
                self.saveSchool()
                return
            }
        }
    }
    
    func saveSchool() {
        do {
            guard let path = Bundle.main.path(forResource: "school", ofType: "json") else {
                print("获取学校列表json文件失败")
                return
            }
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url)
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            let json = JSON(jsonObject).arrayValue
            let schools = json.map { return $0.stringValue }
            UserDefaults.standard.set(schools, forKey: "schools")
        } catch(let error) {
            print(error)
            print("保存学校列表失败")
        }
    }

}
