//
//  Badge.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/4/19.
//

import Foundation

func saveBadge(_ cityName: String) {
    guard var array = UserDefaults.standard.value(forKey: "badge") as? [String] else {
        let array = [cityName]
        UserDefaults.standard.setValue(array, forKey: "badge")
        return
    }
    array.append(cityName)
    UserDefaults.standard.setValue(array, forKey: "badge")
}

func getBadge() -> [String]? {
    return UserDefaults.standard.value(forKey: "badge") as? [String]
}

func removeBadge() {
    UserDefaults.standard.removeObject(forKey: "badge")
}
