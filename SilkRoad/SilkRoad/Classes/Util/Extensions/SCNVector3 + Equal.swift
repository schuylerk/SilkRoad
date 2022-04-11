//
//  SCNVector3 + Equal.swift
//  SilkRoad
//
//  Created by student on 2022/4/5.
//

import Foundation
import UIKit
import SceneKit

extension SCNVector3: Equatable {
    
    public static func == (lhs: SCNVector3, rhs: SCNVector3) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
    }
    
}
