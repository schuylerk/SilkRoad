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
    let viewControllers = [
        StudyViewController(),
        UINavigationController(rootViewController: VRViewController()),
        UINavigationController(rootViewController: HelpFarmersViewController()),
        MineViewController()
    ]
    tabBarController.viewControllers = viewControllers
    guard let items = tabBarController.tabBar.items else { return tabBarController }
    items[0].setFor("学习", image: nil, selectedImage: nil)
    items[1].setFor("VR", image: nil, selectedImage: nil)
    items[2].setFor("助农", image: nil, selectedImage: nil)
    items[3].setFor("我的", image: nil, selectedImage: nil)
    return tabBarController
}
