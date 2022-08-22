//
//  OpenedMHCache.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/8/17.
//

import Foundation

func saveOpenedMHIndexes(cityName: String, index: Int) {
    var openedIndexes: [Int] = []
    if let indexes = getOpenedMHIndexes(cityName: cityName) {
        openedIndexes += indexes
    }
    openedIndexes.append(index)
    UserDefaults.standard.set(openedIndexes, forKey: cityName + "_openedindex")
}

func getOpenedMHIndexes(cityName: String) -> [Int]? {
    return UserDefaults.standard.value(forKey: cityName + "_openedindex") as? [Int]
}