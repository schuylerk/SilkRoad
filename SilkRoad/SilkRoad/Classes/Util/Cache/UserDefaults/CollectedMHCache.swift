//
//  CollectedMHCache.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/8/17.
//

import Foundation

func saveCollectedMHIndexes(cityName: String, mindex: Int) {
    var collectedIndexes: [Int] = []
    if let indexes = getCollectedMHIndexesFor(cityName: cityName) {
        collectedIndexes += indexes
    }
    collectedIndexes.append(mindex)
    UserDefaults.standard.set(collectedIndexes, forKey: cityName)
}

func getCollectedMHIndexesFor(cityName: String) -> [Int]? {
    return UserDefaults.standard.value(forKey: cityName) as? [Int]
}

func removeAllCollectedMHIndexes() {
    UserDefaults.standard.removeObject(forKey: "西安")
    UserDefaults.standard.removeObject(forKey: "兰州")
    UserDefaults.standard.removeObject(forKey: "敦煌")
    UserDefaults.standard.removeObject(forKey: "乌鲁木齐")
    UserDefaults.standard.removeObject(forKey: "西宁")
}
