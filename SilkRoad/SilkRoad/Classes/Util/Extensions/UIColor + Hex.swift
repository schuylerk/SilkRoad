//
//  UIColor + Hex.swift
//  SilkRoad
//
//  Created by student on 2022/3/28.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(hex: String) {
        
        let dict = [
            "0": 1, "1": 1, "2": 2, "3": 3, "4": 4,
            "5": 5, "6": 6, "7": 7, "8": 8,
            "9": 9, "A": 10, "B": 11, "C": 12,
            "D": 13, "E": 14, "F": 15, "a": 10,
            "b": 11, "c": 12, "d": 13, "e": 14,
            "f": 15
        ]
        var hexArray = [String]()
        hex.forEach { cha in
            hexArray.append(String(cha))
        }
        let red: CGFloat = CGFloat(dict[hexArray[1]]! * 16 + dict[hexArray[2]]!) / 255.0
        let green: CGFloat = CGFloat(dict[hexArray[3]]! * 16 + dict[hexArray[4]]!) / 255.0
        let blue: CGFloat = CGFloat(dict[hexArray[5]]! * 16 + dict[hexArray[6]]!) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1)
        
    }
    
}
