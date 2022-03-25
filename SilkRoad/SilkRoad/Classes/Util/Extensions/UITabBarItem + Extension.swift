//
//  UITabBarItem + Extension.swift
//  SilkRoad
//
//  Created by student on 2022/3/25.
//

import Foundation
import UIKit

extension UITabBarItem {
    
    func setFor(_ title: String?, image: UIImage?, selectedImage: UIImage?) {
        self.title = title
        self.image = image
        self.selectedImage = selectedImage
    }
    
}
