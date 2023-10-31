//
//  ColorLayer.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/3/28.
//

import UIKit

class ColorLayer: CALayer {
    
    var gradientLayer: CAGradientLayer!
    
    init(_ startPoint: CGPoint, endPoint: CGPoint, colors: [CGColor], locations: [NSNumber]) {
        super.init()
        
        self.gradientLayer = CAGradientLayer()
        self.gradientLayer.startPoint = startPoint
        self.gradientLayer.endPoint = endPoint
        self.gradientLayer.colors = colors
        self.gradientLayer.locations = locations
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers() {
        super.layoutSublayers()
        
        gradientLayer.frame = bounds
    }
    
    func setup() {
        self.addSublayer(gradientLayer)
    }
    
}
