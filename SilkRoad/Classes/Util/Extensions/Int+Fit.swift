//
//  Int + Fit.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/3/19.
//

import Foundation
import UIKit

extension Int {
    
    //基于iPhone 13 Pro Max
    
    var fw: Int {
        return Int(Float(self) * Float(UIScreen.main.bounds.size.width / 428.0))
    }
    
    var fh: Int {
        return Int(Float(self) * Float(UIScreen.main.bounds.size.height / 926.0))
    }

}
