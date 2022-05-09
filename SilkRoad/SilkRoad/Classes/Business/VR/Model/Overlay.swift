//
//  Overlay.swift
//  SilkRoad
//
//  Created by student on 2022/4/5.
//

import Foundation
import UIKit
import SceneKit

///遮罩模型
struct Overlay {
    var width: CGFloat
    var height: CGFloat
    var position: SCNVector3
    var rotation: SCNVector4?
    var cullMode: SCNCullMode
    
    var cultureRelic: CultureRelic //文物数据
}
