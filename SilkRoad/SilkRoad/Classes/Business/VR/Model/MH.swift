//
//  MH.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/8/10.
//

import Foundation

struct MH {
    var type: Int = 0
    var story: String = ""
    var cultureRelic = CultureRelic()
    var position: Position
    var rotation: Rotation
    var preRotation: Rotation
}

struct Position {
    var x: Float
    var y: Float
    var z: Float
}

struct Rotation {
    var x: Float
    var y: Float
    var z: Float
}
