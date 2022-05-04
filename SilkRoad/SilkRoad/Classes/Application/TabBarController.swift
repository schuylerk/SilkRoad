//
//  TabBarController.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/3/24.
//

import Foundation
import UIKit
import ESTabBarController_swift

func tabBar(didHijackHandler: @escaping ESTabBarControllerDidHijackHandler) -> ESTabBarController {
    let tabBarController = ESTabBarController()
    let StudyVC = StudyViewController()
    let VRVC = VREntryViewController()
    let otherVC = OtherViewController()
    let HelpVC = HelpFarmersViewController()
    let MineVC = MineViewController()

    let StudyNavi = UINavigationController(rootViewController: StudyVC)
    let VRNavi = UINavigationController(rootViewController: VRVC)
    let otherNavi = UINavigationController(rootViewController: otherVC)
    let HelpNavi = UINavigationController(rootViewController: HelpVC)
    let MineNavi = UINavigationController(rootViewController: MineVC)
    
    StudyVC.tabBarItem = ESTabBarItem(ESTabBarItemCustomColorContentView(), title: nil, image: UIImage(named: "stu"), selectedImage: nil, tag: 0)
    VRVC.tabBarItem = ESTabBarItem(ESTabBarItemCustomColorContentView(), title: nil, image: UIImage(named: "luxian"), selectedImage: nil, tag: 1)
    otherVC.tabBarItem = ESTabBarItem(ESTabBarItemCustomColorContentView(), title: nil, image: UIImage(named: "other"), selectedImage: nil, tag: 2)
    HelpVC.tabBarItem = ESTabBarItem(ESTabBarItemCustomColorContentView(), title: nil, image: UIImage(named: "hf"), selectedImage: nil, tag: 3)
    MineVC.tabBarItem = ESTabBarItem(ESTabBarItemCustomColorContentView(), title: nil, image: UIImage(named: "min"), selectedImage: nil, tag: 4)
    
    tabBarController.viewControllers = [StudyNavi, VRNavi, otherNavi, HelpNavi, MineNavi]
    tabBarController.shouldHijackHandler = { _, _, index -> Bool in
        if index == 2 {
            return true
        }
        return false
    }
    tabBarController.didHijackHandler = didHijackHandler
    return tabBarController
}

class ESTabBarItemCustomColorContentView: ESTabBarItemContentView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        highlightIconColor = UIColor(red: 0.922, green: 0.624, blue: 0.349, alpha: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
