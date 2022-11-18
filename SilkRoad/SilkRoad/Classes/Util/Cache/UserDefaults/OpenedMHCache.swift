//
//  OpenedMHCache.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/8/17.
//

import Foundation

func saveOpenedMHIndexes(cityName: String, index: Int) {
    var openedIndexes: [Int] = []
    if let indexes = getOpenedMHIndexes(cityName: cityName) { openedIndexes += indexes }
    openedIndexes.append(index)
    UserDefaults.standard.set(openedIndexes, forKey: cityName + "_openedindex")
}

func getOpenedMHIndexes(cityName: String) -> [Int]? {
    return UserDefaults.standard.value(forKey: cityName + "_openedindex") as? [Int]
}

func removeOpenedMHIndexes() {
    let keys = ["西安", "兰州", "乌鲁木齐", "敦煌", "西宁"].map { $0 + "_openedindex" }
    keys.forEach { UserDefaults.standard.removeObject(forKey: $0) }
}
