//
//  SceneDelegate.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/3/19.
//

import UIKit
import SwiftyJSON
import HandyJSON
import ESTabBarController_swift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    var window_2: UIWindow!
    
    var tabBarController: ESTabBarController!
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        tabBarController = tabBar { _, _, _ in
//            self.window_2.isHidden = false
//            UIView.animate(withDuration: 0.5, animations: {
//                self.arButton.center = CGPoint(x: screenWidth / 2 - 40, y: screenHeight - 150)
//                self.playButton.center = CGPoint(x: screenWidth / 2 + 40, y: screenHeight - 150)
//            })
        }
//
        tabBarController.selectedIndex = 2
        
        guard UserDefaults.standard.value(forKey: "user") != nil else {
            let user = createUser()
            saveUser(user)
            window?.rootViewController = tabBarController
            return
        }
        window?.rootViewController = tabBarController
//        configWindow(windowScene: windowScene)
    }
    
    var arButton: UIButton!
    var playButton: UIButton!
    
    func configWindow(windowScene: UIWindowScene) {
        window_2 = UIWindow(windowScene: windowScene)
        window_2.windowLevel = .statusBar
        window_2.backgroundColor = .clear
        arButton = UIButton(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
        arButton.center = CGPoint(x: screenWidth / 2 , y: screenHeight - 70)
        arButton.setImage(UIImage(named: "ar"), for: .normal)
        arButton.addTarget(self, action: #selector(goAR), for: .touchUpInside)
        playButton = UIButton(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
        playButton.center = CGPoint(x: screenWidth / 2, y: screenHeight - 70)
        playButton.setImage(UIImage(named: "play"), for: .normal)
        playButton.addTarget(self, action: #selector(goPlay), for: .touchUpInside)
        window_2.addSubview(playButton)
        window_2.addSubview(arButton)
        let blackButton = UIButton(frame: UIScreen.main.bounds)
        blackButton.backgroundColor = .black
        blackButton.alpha = 0.2
        blackButton.addTarget(self, action: #selector(tapBlackButton), for: .touchUpInside)
        window_2.addSubview(blackButton)
        window_2.addSubview(playButton)
        window_2.addSubview(arButton)
    }
    
    @objc func goAR() {
        tapBlackButton()
        let vc = getBackVC()
        vc?.navigationController?.pushViewController(ARViewController(), animated: true)
    }
    
    @objc func goPlay() {
        tapBlackButton()
        let vc = getBackVC()
        vc?.navigationController?.pushViewController(PlayViewController(), animated: true)
    }
    
    @objc func getBackVC() -> UIViewController? {
        let selectedIndex = tabBarController.selectedIndex
        guard let navi = tabBarController.selectedViewController as? UINavigationController else { return nil }
        var vc = navi.topViewController
        switch selectedIndex {
        case 0:
            vc = vc as! StudyViewController
        case 1:
            vc = vc as! VREntryViewController
        case 3:
            vc = vc as! HelpFarmersViewController
        case 4:
            vc = vc as! MineViewController
        default:
            return vc
        }
        return vc
    }
    
    @objc func tapBlackButton() {
        arButton.center = CGPoint(x: screenWidth / 2 , y: screenHeight - 70)
        playButton.center = CGPoint(x: screenWidth / 2, y: screenHeight - 70)
        window_2.isHidden = true
    }

}
