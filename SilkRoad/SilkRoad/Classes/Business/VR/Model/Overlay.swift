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
    
    var cultureRelic: CultureRelic = CultureRelic()//文物数据
    var story: String = ""
    var type: Int = 0
}
