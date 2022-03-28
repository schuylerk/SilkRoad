//
//  UIColor + Hex .swift
//  SilkRoad
//
//  Created by 康思为 on 2022/3/28.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(hex: String) {
        
        let dict = [
            "1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9,
            "a": 10,"b": 11, "c": 12, "d": 13, "e": 14, "f": 15,
            "A": 10 ,"B": 11, "C": 12, "D": 13, "E": 14, "F": 15,
        ]
        var stringArray = [String]()
        for char in hex {
            stringArray.append(String(char))
        }
        let red = Double(dict[stringArray[1]]!*16 + dict[stringArray[2]]!) / 255.0
        let green = Double(dict[stringArray[3]]!*16 + dict[stringArray[4]]!) / 255.0
        let blue = Double(dict[stringArray[5]]!*16 + dict[stringArray[6]]!) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
}
