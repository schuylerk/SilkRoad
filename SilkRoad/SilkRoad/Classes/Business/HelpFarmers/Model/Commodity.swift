//
//  Commodity.swift
//  SilkRoad
//
//  Created by student on 2022/3/28.
//

import Foundation
import UIKit

struct Commodity {
    var face: String = ""
    var description: String = ""
    var purchasedNum: Int = 0
    var price: CGFloat = 0.0
    
    func descriptionRect() -> CGRect {
        let label = UILabel()
        label.text = description
        label.font = UIFont(name: "Arial", size: 16)
        label.lineBreakMode = .byWordWrapping
        return label.textRect(forBounds: CGRect(x: 0, y: 0, width: 150, height: screenHeight), limitedToNumberOfLines: 3)
    }
}
