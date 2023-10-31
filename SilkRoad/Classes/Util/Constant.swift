//
//  Constant.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/3/19.
//

import Foundation
import UIKit
import AVFoundation

let screenWidth = UIScreen.main.bounds.size.width //屏幕宽度
let screenHeight = UIScreen.main.bounds.size.height //屏幕高度

let deviceName = UIDevice.current.name

let statusBarHeight: CGFloat =  {
    switch deviceName {
    case "iPhone 4", "iPhone 4S", "iPhone 5", "iPhone 5S", "iPhone 5C", "iPhone 6", "iPhone 6S", "iPhone SE(2016)", "iPhone 6S Plus", "iPhone 7", "iPhone 7 Plus", "iPhone 8", "iPhone 8 Plus", "iPhone SE(2020/2022)":
        return 20
    case "iPhone X", "iPhone XS", "iPhone XS Max", "iPhone XR", "iPhone 11", "iPhone 11 Pro", "iPhone 11 Pro Max", "iPhone 12 mini", "iPhone 12", "iPhone 12 Pro", "iPhone 12 Pro Max", "iPhone 13", "iPhone 13 Pro", "iPhone 13 mini", "iPhone 13 Pro Max":
        return 44
    default:
        return 44
    }
}()

let navigationBarHeight = 44

let tabBarHeight: CGFloat = {
    switch deviceName {
    case "iPhone 4", "iPhone 4S", "iPhone 5", "iPhone 5S", "iPhone 5C", "iPhone 6", "iPhone 6S", "iPhone SE(2016)", "iPhone 6S Plus", "iPhone 7", "iPhone 7 Plus", "iPhone 8", "iPhone 8 Plus", "iPhone SE(2020/2022)", "iPhone 12 mini", "iPhone 12", "iPhone 12 Pro", "iPhone 12 Pro Max", "iPhone 13", "iPhone 13 Pro", "iPhone 13 mini", "iPhone 13 Pro Max":
        return 49
    case "iPhone X", "iPhone XS", "iPhone XS Max", "iPhone XR", "iPhone 11", "iPhone 11 Pro", "iPhone 11 Pro Max":
        return 83
    default:
        return 49
    }
}()

let bottomSafeAreaHeight: CGFloat = {
    switch deviceName {
    case "iPhone X", "iPhone XS", "iPhone XS Max", "iPhone XR", "iPhone 11", "iPhone 11 Pro", "iPhone 11 Pro Max", "iPhone 12 mini", "iPhone 12", "iPhone 12 Pro", "iPhone 12 Pro Max", "iPhone 13", "iPhone 13 Pro", "iPhone 13 mini", "iPhone 13 Pro Max":
        return 34
    default:
        return 0
    }
}()
