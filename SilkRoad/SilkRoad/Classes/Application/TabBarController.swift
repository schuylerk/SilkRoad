//
//  TabBarController.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/3/24.
//

import Foundation
import UIKit
import ESTabBarController_swift

func tabBar() -> UITabBarController {
    let tabBarController = UITabBarController()
    
    let StudyVC = StudyViewController()
    let VRVC = VREntryViewController()
    let HelpVC = HelpFarmersViewController()
    let MineVC = MineViewController()
    let otherVC = OtherViewController()
    
    let StudyNavi = UINavigationController(rootViewController: StudyVC)
    let VRNavi = UINavigationController(rootViewController: VRVC)
    let HelpNavi = UINavigationController(rootViewController: HelpVC)
    let MineNavi = UINavigationController(rootViewController: MineVC)
    let otherNavi = UINavigationController(rootViewController: otherVC)
    
    let viewControllers = [StudyNavi, VRNavi, otherNavi, HelpNavi, MineNavi]
    tabBarController.viewControllers = viewControllers
    guard let items = tabBarController.tabBar.items else { return tabBarController }
    items[0].setFor(nil, image: UIImage(named: "stu"), selectedImage: nil)
    items[1].setFor(nil, image: UIImage(named: "luxian"), selectedImage: nil)
    items[2].setFor(nil, image: UIImage(named: "other"), selectedImage: nil)
    items[3].setFor(nil, image: UIImage(named: "hf"), selectedImage: nil)
    items[4].setFor(nil, image: UIImage(named: "min"), selectedImage: nil)
    tabBarController.tabBar.tintColor = UIColor(red: 0.922, green: 0.624, blue: 0.349, alpha: 1)
    tabBarController.tabBar.barTintColor = UIColor.white
    items[0].imageInsets = UIEdgeInsets(top: 3, left: 3, bottom: -30, right: 0)
    items[1].imageInsets = UIEdgeInsets(top: 3, left: 3, bottom: -30, right: 0)
    items[2].imageInsets = UIEdgeInsets(top: 3, left: 3, bottom: -30, right: 0)
    items[3].imageInsets = UIEdgeInsets(top: 3, left: 3, bottom: -30, right: 0)
    items[4].imageInsets = UIEdgeInsets(top: 3, left: 3, bottom: -30, right: 0)
    return tabBarController
}

//func tabbar() -> ESTabBarController {
//    let tabBarController = ESTabBarController()
//
//    let StudyVC = StudyViewController()
//    let VRVC = VREntryViewController()
//    let HelpVC = HelpFarmersViewController()
//    let MineVC = MineViewController()
//
//    let StudyNavi = UINavigationController(rootViewController: StudyVC)
//    let VRNavi = UINavigationController(rootViewController: VRVC)
//    let HelpNavi = UINavigationController(rootViewController: HelpVC)
//    let MineNavi = UINavigationController(rootViewController: MineVC)
//    return tabBarController
//}
