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
    let keys = ["西安", "兰州", "敦煌", "乌鲁木齐", "西宁"]
    keys.forEach { UserDefaults.standard.removeObject(forKey: $0) }
}
