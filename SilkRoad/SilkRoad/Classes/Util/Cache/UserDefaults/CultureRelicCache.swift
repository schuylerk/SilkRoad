//
//  CultureRelicCache.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/4/19.
//

import Foundation

func saveCultureRelicFor(_ name: String, city: String) {
    guard var cultureRelics = UserDefaults.standard.value(forKey: city) as? [String] else {
        UserDefaults.standard.setValue([name], forKey: city)
        return
    }
    cultureRelics.append(name)
    UserDefaults.standard.setValue(cultureRelics, forKey: city)
}

func getCollectedCultureRelic(_ city: String) -> [String]? {
    return UserDefaults.standard.value(forKey: city) as? [String]
}
