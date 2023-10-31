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
        guard hex.isHexString() else {
            self.init(red: 0, green: 0, blue: 0, alpha: 1)
            return
        }
        let (red, green, blue) = hex.getRGB()
        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1)
    }
    
}

extension String {
    
    func isHexString() -> Bool {
        let dict = [
            "0": 0, "1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9,
            "a": 10,"b": 11, "c": 12, "d": 13, "e": 14, "f": 15,
            "A": 10 ,"B": 11, "C": 12, "D": 13, "E": 14, "F": 15,
        ]
        var stringArray = [String]()
        for char in self {
            stringArray.append(String(char))
        }
        guard stringArray.count == 7 else {
            print("hex格式错误，构建Color失败（长度）")
            return false
        }
        for (inx, vle) in stringArray.enumerated() {
            if inx == 0 { continue }
            let count = dict.filter({ key, _ in
                key == vle
            }).count
            guard count > 0 else {
                print("hex格式错误，构建Color失败（非法字符）")
                return false
            }
        }
        return true
    }
    
    func getRGB() -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
        let dict = [
            "0": 0, "1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9,
            "a": 10,"b": 11, "c": 12, "d": 13, "e": 14, "f": 15,
            "A": 10 ,"B": 11, "C": 12, "D": 13, "E": 14, "F": 15,
        ]
        var stringArray = [String]()
        for char in self {
            stringArray.append(String(char))
        }
        let red = Double(dict[stringArray[1]]!*16 + dict[stringArray[2]]!)
        let green = Double(dict[stringArray[3]]!*16 + dict[stringArray[4]]!)
        let blue = Double(dict[stringArray[5]]!*16 + dict[stringArray[6]]!)
        return (red, green, blue)
    }
    
}

extension Int {
    
    func toHexString(length: Int? = nil) -> String {
        let dict = [10: "a", 11: "b", 12: "c", 13: "d", 14: "e", 15: "f"]
        var arr: [Int] = []
        var value = self
        while value > 0 {
            arr.append(value % 16)
            value = value / 16
        }
        arr = arr.reversed()
        var string = ""
        arr.forEach {
            if $0 >= 10 {
                string += dict[$0]!
            } else {
                string += "\($0)"
            }
        }
        guard let len = length else {
            return string
        }
        if string.count < len {
            return String(repeating: "0", count: len - string.count) + string
        }
        return string
    }
    
}
