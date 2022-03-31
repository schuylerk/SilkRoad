//
//  TabBarController.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/3/24.
//

import Foundation
import UIKit

func tabBar() -> UITabBarController {
    let tabBarController = UITabBarController()
    
    let StudyVC = StudyViewController()
    let VRVC = VRViewController()
    let HelpVC = HelpFarmersViewController()
    let MineVC = MineViewController()
    
    let StudyNavi = UINavigationController(rootViewController: StudyVC)
    let VRNavi = UINavigationController(rootViewController: VRVC)
    let HelpNavi = UINavigationController(rootViewController: HelpVC)
    let MineNavi = UINavigationController(rootViewController: MineVC)
    
    let viewControllers = [StudyNavi, VRNavi, HelpNavi, MineNavi]
    
    tabBarController.viewControllers = viewControllers
    guard let items = tabBarController.tabBar.items else { return tabBarController }
    items[0].setFor("学习", image: nil, selectedImage: nil)
    items[1].setFor("VR", image: nil, selectedImage: nil)
    items[2].setFor("助农", image: nil, selectedImage: nil)
    items[3].setFor("我的", image: nil, selectedImage: nil)
    return tabBarController
}
